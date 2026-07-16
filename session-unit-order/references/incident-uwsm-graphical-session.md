# Incident pointer — UWSM × graphical-session

**One-line cause:** `Wants=graphical-session.target` on Persistent eye-comfort oneshots under Linger activated the target before UWSM, so first login after shutdown aborted.

**One-line fix:** `After=graphical-session.target` only; never pull the target from timer-driven oneshots.

**Full regression report (arch-machine):**  
`modules/productivity/eye-comfort/docs/REGRESSION-UWSM-SESSION.md`  
Repo: https://github.com/p10ns11y/arch-machine

**Fingerprint:**

```text
Reached target Current graphical user session
uwsm: A compositor or graphical-session* target is already active!
sddm-helper exited with 1
```
