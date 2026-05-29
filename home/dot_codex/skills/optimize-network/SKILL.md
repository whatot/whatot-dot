---
name: optimize-network
description: Use when diagnosing slow network, DNS delay, packet loss, proxy routing, AI tool connectivity, Wi-Fi issues, or Chinese requests like 网络慢, 代理线路, DNS 慢.
---

# Optimize Network

Use this skill for network diagnosis and cautious optimization. The default is
read-only evidence gathering, with small reversible changes only after user
approval.

## Safety Rules

- Protect VPN, proxy, TUN, and routing tools such as Clash, Mihomo, Surge,
  Tailscale, WireGuard, V2Ray, Shadowrocket, and corporate VPNs.
- Do not stop, restart, unload, delete, or bypass proxy/VPN tooling unless the
  user explicitly asks for that exact change.
- Treat remote sessions carefully. Ask before any command that could disconnect
  SSH, remote desktop, RustDesk, Tailscale, or VPN access.
- Commands requiring `sudo`, interface down/up, route changes, or DNS changes
  need a short proposal and explicit approval.
- Do not claim improvement from one noisy measurement.

## Diagnosis Order

1. Identify OS, active route, proxy state, and DNS state.
2. Measure local link quality first: gateway ping, Wi-Fi signal, packet loss.
3. Measure external responsiveness: DNS timing, selected endpoint latency, and
   bandwidth only when useful.
4. Check proxy path if AI tools or package registries are slow.
5. Separate confirmed facts from hypotheses.

## macOS Read-Only Commands

```bash
rtk uname -a
rtk sw_vers 2>/dev/null || true
rtk scutil --nwi 2>/dev/null || true
rtk scutil --dns 2>/dev/null || true
rtk scutil --proxy 2>/dev/null || true
rtk route -n get default 2>/dev/null || true
rtk networkQuality -v 2>/dev/null || true
```

Use bandwidth-consuming tests only when they answer the user's question.

## Optimization Menu

Propose changes as reversible experiments:

- DNS A/B test: save current DNS, test candidate DNS, flush cache, compare, then
  keep or roll back.
- Service order: show current order before proposing a new one.
- AWDL/AirDrop test: temporary only, explain impact on AirDrop/Handoff.
- Background traffic: report top talkers; do not kill processes without
  approval.
- Bufferbloat: prefer router-side SQM guidance when evidence supports it.
- Proxy route: inspect read-only status first and avoid exposing secrets.

## Expected Output

Report:

- Goal and active network path.
- Evidence gathered.
- Top 1-3 likely bottlenecks.
- Safe next action, expected effect, and rollback.
