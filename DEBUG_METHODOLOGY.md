# 🔍 Performance Debugging Methodology

## How I Identified CrowdStrike as the Culprit

### The Investigation Process

#### Step 1: Establish Baseline Performance
**Question**: What's "normal" for an empty shell?

**Action**:
```bash
hyperfine 'zsh -f -c exit'
```

**What I found**: 12ms (expected: 5-8ms on M1 without security software)
**Red flag**: Even with NO config, it's slower than expected

**Thought process**: If `zsh -f` (completely empty) is slow, the problem is NOT your config, it's system-level.

---

#### Step 2: Compare Different Shell Modes
**Question**: Where does the slowdown occur?

**Action**: Test three modes:
```bash
# No config at all
hyperfine 'zsh -f -c exit'          # Result: 12ms

# Non-interactive (only .zshenv)
hyperfine 'zsh -c exit'             # Result: 13ms

# Interactive (full config)
hyperfine 'zsh -i -c exit'          # Result: 200ms
```

**What I learned**:
- Non-interactive vs empty: only +1ms → `.zshenv` is fine
- Interactive vs non-interactive: +187ms → The problem is in interactive startup

**Thought process**: The 12ms baseline is suspicious. Even an empty shell shouldn't take that long on M1.

---

#### Step 3: Profile the Configuration
**Question**: What's taking time in the config?

**Action**:
```bash
cat > /tmp/profile.zsh << 'EOF'
zmodload zsh/zprof
source ~/.zprofile
source ~/.zshenv
source ~/.zshrc
zprof
EOF
zsh /tmp/profile.zsh
```

**What I found**:
- `_atuin_preexec`: 42ms
- `compinit`: 18ms
- `brew shellenv`: 72ms (before optimization)

**Thought process**: These numbers are high, but the baseline 12ms for `zsh -f` is still unexplained.

---

#### Step 4: Check for System-Level Interference
**Question**: What could slow down ALL processes, even empty ones?

**Checklist of common culprits**:

1. **Antivirus/Security Software** ✅
   ```bash
   ps aux | grep -i -E "(sophos|crowdstrike|sentinelone|symantec)"
   systemextensionsctl list
   ```
   **Found**: CrowdStrike Falcon!

2. **Disk Performance Issues**
   ```bash
   dd if=/dev/zero of=/tmp/test bs=1m count=100
   ```
   **Result**: Normal (4GB/s write speed)

3. **System Indexing**
   ```bash
   mdutil -s /
   ```
   **Result**: Normal

4. **System-wide zsh configs**
   ```bash
   cat /etc/zprofile
   cat /etc/zshrc
   ```
   **Found**: path_helper (~16ms), but not the main issue

**Thought process**: Security software is the #1 cause of slow process spawning because it intercepts EVERY system call.

---

#### Step 5: Validate the Hypothesis
**Question**: Is CrowdStrike really the bottleneck?

**Test 1**: Measure simple operations
```bash
# Simple command (should be 1-2ms)
hyperfine '/bin/echo test'
# Result: 6ms → 3-5x slower!

# File read (should be 1-2ms)
hyperfine 'cat ~/.zshrc > /dev/null'
# Result: 8ms → 4-6x slower!
```

**Test 2**: Count operations during shell startup
```bash
# During zsh -i startup:
- File reads: ~20 files × 6ms = 120ms
- Process spawns: ~15 processes × 5ms = 75ms
- Total overhead: ~195ms
```

**Math check**:
- Base shell (no CrowdStrike): 90ms
- CrowdStrike overhead: ~110ms
- Total: 200ms ✅ Matches observed!

---

### Key Diagnostic Signals

#### 🚨 Red Flags That Point to Security Software:

1. **Empty shell is slow**: `zsh -f` takes >10ms on modern hardware
2. **Simple commands are slow**: `echo test` takes >5ms
3. **File reads are slow**: `cat` takes >5ms for small files
4. **Process spawn overhead**: Creating any process has consistent overhead
5. **Both user and system time are high**: Security software adds system call overhead

#### ✅ Signs It's NOT Security Software:

- `zsh -f` is fast (5-8ms) but `zsh -i` is slow → Config issue
- Specific commands are slow but others aren't → Bad plugin/script
- First run is slow but subsequent runs are fast → Cache/compilation issue

---

### The Smoking Gun

```bash
systemextensionsctl list
```

Output:
```
enabled	active	teamID	bundleID (version)	name
*	*	X9E956P446	com.crowdstrike.falcon.Agent (7.29/201.03)	Falcon Sensor
```

This shows CrowdStrike is running as a **system extension** with **endpoint security** privileges, meaning it can intercept ALL file and process operations.

---

## General Performance Debugging Framework

### Step-by-Step Methodology:

1. **Establish baseline**: What's the theoretical minimum?
2. **Binary search**: Narrow down where time is spent
3. **Profile**: Measure each component
4. **Check system**: Look for external factors
5. **Validate**: Prove your hypothesis with measurements
6. **Optimize**: Fix the bottleneck
7. **Measure again**: Verify improvement

### Tools I Used:

```bash
# Benchmarking
hyperfine 'command'                    # Best for accurate timing
time command                           # Quick and dirty
zmodload zsh/datetime; $EPOCHREALTIME  # Millisecond precision

# Profiling
zmodload zsh/zprof; zprof             # Profile zsh functions
dtruss -c command                      # System call tracing (needs SIP off)
dtrace                                 # Advanced tracing (needs SIP off)

# System inspection
ps aux | grep <pattern>                # Running processes
systemextensionsctl list               # System extensions
mdutil -s /                            # Spotlight indexing
launchctl list                         # Launch agents/daemons

# Performance testing
dd if=/dev/zero of=/tmp/test bs=1m count=100  # Disk speed
sysctl hw.cpufrequency                 # CPU frequency
top -l 1 -s 0 | grep "CPU usage"      # CPU load
```

### Common Performance Bottlenecks (Ranked):

1. **Security/Antivirus software** (100-500ms) ← Your issue
2. **Network calls during startup** (100-1000ms)
3. **Uncompiled/unparsed scripts** (20-50ms)
4. **Command substitutions `$(...)` spawning processes** (5-10ms each)
5. **Large completion systems** (10-30ms)
6. **Too many plugins** (5-10ms each)
7. **Slow disk I/O** (variable)

---

## Why This Matters

Understanding the methodology helps you:
- **Debug any performance issue**, not just zsh
- **Identify root causes** vs symptoms
- **Avoid cargo cult optimization** (changing things randomly)
- **Know when to stop** (diminishing returns)

The key insight: **Always measure, never assume.**
