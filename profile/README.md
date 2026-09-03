<p align="center">
  <img src="https://raw.githubusercontent.com/public-software/.github/main/brand/ledger.png" width="320" alt="The Public Software ledger">
</p>
<p align="center"><b>Public Software</b> · Software as public infrastructure.</p>

Public Software is a from-scratch, spec-first reimplementation of the software world as one suite: firmware, kernel, toolchain, desktop, office, media, engineering, enterprise — written in Rust, held in public. Every repository signs the same seven contracts, so the parts fit. Nothing here is a fork.

**Current train:** none yet · **Nightly suite build:** not yet running · [Ledger](https://github.com/public-software/catalog) · [Roadmap](https://github.com/public-software/catalog) · [Charter](https://github.com/public-software/docs)

## Start here
- New to the suite → the handbook in [`docs`](https://github.com/public-software/docs)
- Want to build → `cargo install pub` then `pub suite pull`
- Want to help → [good first issues across the org](https://github.com/search?q=org%3Apublic-software+label%3A%22good+first+issue%22+state%3Aopen&type=issues) · [open RFCs](https://github.com/public-software/rfcs/pulls)

## The suite
<!-- catalog:tables -->

### Spine — defines, assembles and documents everything else

| Repository | Purpose | Layers | Starts |
|---|---|---|---|
| [catalog](https://github.com/public-software/catalog) | Machine-readable ledger + roadmap; source of truth for GitHub descriptions, topics, properties and the org README. | L18 | wave 1 |
| [interfaces](https://github.com/public-software/interfaces) | Every cross-repo API as WIT packages and wire schemas, with generated binding crates. | all | wave 1 |
| [suite](https://github.com/public-software/suite) | The superproject: lockfile pinning every crate, nightly whole-suite build, compatibility matrix, release trains, reference images. | all | wave 1 |
| [rfcs](https://github.com/public-software/rfcs) | Design proposals that cross repos or change an interface. Template, comment window, decision log. | all | wave 1 |
| [docs](https://github.com/public-software/docs) | The suite handbook: architecture, contracts, contributor guide, per-repo mdBooks aggregated into one site. | all | wave 1 |
| [.github](https://github.com/public-software/.github) | Org profile, reusable workflows, issue/PR templates, CODE_OF_CONDUCT, SECURITY, CONTRIBUTING, label definitions. | all | wave 1 |
| [pub](https://github.com/public-software/pub) | The org CLI: scaffold repos from templates, lint conventions, sync catalog → GitHub, pull and build the whole suite. | L2 | wave 1 |
| [templates](https://github.com/public-software/templates) | Repo and crate templates the CLI stamps out: lib, app, service, plugin, spec. | all | wave 1 |

### Platform ring — the only cross-ring dependencies

| Repository | Purpose | Layers | Starts |
|---|---|---|---|
| [platform](https://github.com/public-software/platform) | Foundational crates every repo uses: errors, config layering, tracing facade, paths, i18n (fluent), settings schema, diagnostics bundle. | L4 | wave 1 |
| [design-system](https://github.com/public-software/design-system) | Tokens, type scale, icons, motion, shortcut map, command palette spec — the one look and feel. | L10 | wave 1 |
| [ui](https://github.com/public-software/ui) | The GUI toolkit driven to GTK/Qt completeness with AccessKit and IME built in; app shell, window/tab model, settings UI, command palette. | L10, L4 | wave 2 |
| [doc-model](https://github.com/public-software/doc-model) | CRDT document graph + container format + embed/export protocol. Every productivity and creative document is one of these. | L12 | wave 1 |
| [plugin-runtime](https://github.com/public-software/plugin-runtime) | WASM Component Model host, capability policy, plugin test-kit, plugin packaging. | L2 | wave 1 |
| [identity](https://github.com/public-software/identity) | IdP (Kanidm-derived), OIDC/passkeys client, account picker, secrets vault client, attestation verifier (later), digital ID wallet core. | L6 | wave 1 |
| [pkg](https://github.com/public-software/pkg) | Content-addressed reproducible package manager (Nix model) and the build cache; the distribution mechanism for the suite. | L4 | wave 1 |
| [observe](https://github.com/public-software/observe) | Metrics/trace/log schema, OTel exporters, dashboards & alerting product (Grafana-class) on the Rust stores. | L8 | wave 1 |

### System ring — toolchain, silicon, kernel, base, infrastructure, media, platform shells

| Repository | Purpose | Layers | Starts |
|---|---|---|---|
| [compiler](https://github.com/public-software/compiler) | Rust-native optimizing backend on Cranelift, bootstrap seed, scripting runtimes to parity, C→Rust migration tooling. | L2 | wave 1 |
| [linker](https://github.com/public-software/linker) | Wild linker with Mach-O and PE, assembler and object tooling for all targets. | L2 | wave 1 |
| [devtools](https://github.com/public-software/devtools) | Native debugger (DAP), pure-Rust fuzzer, profilers, formal-verification harness integration. | L2 | wave 1 |
| [firmware](https://github.com/public-software/firmware) | Rust UEFI implementation, oreboot on openSIL boards, TPM 2.0 firmware, BMC (Redfish), firmware update service. | L1 | wave 1 |
| [hdl](https://github.com/public-software/hdl) | Rust HDL, fast cycle simulator, verification library; the root of the silicon chain. | L0 | wave 1 |
| [eda](https://github.com/public-software/eda) | RTL-to-GDS flow, FPGA bitstream reverse engineering and place-and-route, targeting IHP/sky130 and open FPGAs. | L0 | wave 2 |
| [silicon](https://github.com/public-software/silicon) | Open chip designs: root of trust, RF front-end control, FPGA GPU, reference RISC-V platform definitions; shuttle submissions. | L0 | wave 3 |
| [kernel](https://github.com/public-software/kernel) | Kernel hardening (Redox-derived microkernel and Asterinas-style Linux-ABI), scheduler, capability security, driver ABI, libc. | L3, L4 | wave 1 |
| [drivers](https://github.com/public-software/drivers) | Device drivers: GPU (Nova/Tyr/Asahi tracks + Rust Vulkan userspace), storage, USB, network, Wi-Fi/BT host, audio server, camera, input, power. | L3 | wave 2 |
| [base](https://github.com/public-software/base) | Init & service manager, journal, util-linux/procps parity, disk encryption, accessibility bus, screen reader. | L4 | wave 1 |
| [virt](https://github.com/public-software/virt) | Type-1 hypervisor, VMM integration, container runtime integration, sandboxing. | L3 | wave 2 |
| [net](https://github.com/public-software/net) | Host TCP/IP stack, routing suite + dataplane, 5G core, push distributor, SSH daemon, VPN suite. | L5 | wave 1 |
| [sdr](https://github.com/public-software/sdr) | SDR framework with GPU DSP, GNSS receiver, SDR 4G/5G UE (lab/private-network) — the modem programme. | L0, L5 | wave 1 |
| [store](https://github.com/public-software/store) | Relational engine (Postgres-class), KV, cache (Valkey-compatible), graph, object/block store (Ceph-class), streaming (Kafka-protocol), ETL, spreadsheet engine. | L7 | wave 1 |
| [cloud](https://github.com/public-software/cloud) | Container orchestration control plane (K8s-API compatible), IaaS control plane, IaC engine, config management, OCI registry, CI runner. | L8 | wave 1 |
| [forge](https://github.com/public-software/forge) | Code forge (repos, issues, reviews, packages, federation) on gitoxide; the future canonical home of this org. | L8 | wave 2 |
| [security](https://github.com/public-software/security) | Secrets manager + PKCS#11, CA product, endpoint sensor + detection engine, SIEM correlation, transparency log. | L6 | wave 1 |
| [comms](https://github.com/public-software/comms) | Mail client, chat clients (Matrix, Signal-class), SIP/PBX, video-meeting SFU + client, federated social server. | L5, L12 | wave 1 |
| [graphics](https://github.com/public-software/graphics) | Shader toolchain hardening (naga), software Vulkan/WebGPU rasterizer, colour management, OCR. | L9 | wave 1 |
| [media](https://github.com/public-software/media) | FFmpeg-class framework, Opus encoder + IAMF, player, streaming server, screen capture / live production. | L9 | wave 1 |
| [js](https://github.com/public-software/js) | JavaScript engine with JIT tiers; Node-class runtime on it. | L11 | wave 2 |
| [desktop](https://github.com/public-software/desktop) | Compositor features, desktop environment completeness, input methods, portals, session. | L10 | wave 2 |
| [mobile](https://github.com/public-software/mobile) | Mobile OS assembly: modem quarantine architecture, app store + reproducible builds, push, wallet integration, device support. | L10 | wave 3 |
| [web](https://github.com/public-software/web) | Servo work (a11y, layout, editing), browser product, PDF render/edit, maps renderer + router, CMS, analytics. | L11 | wave 1 |
| [ai](https://github.com/public-software/ai) | Burn/CubeCL work on open backends, inference server, distributed training, TTS, voice assistant, CV, model recipes. | L15 | wave 1 |

### Domain ring — the products

| Repository | Purpose | Layers | Starts |
|---|---|---|---|
| [office](https://github.com/public-software/office) | Word processor, spreadsheet application, presentations, document format libraries. | L12, L7 | wave 1 |
| [workspace](https://github.com/public-software/workspace) | Notes & knowledge base, project management, file sync, whiteboard, design tool, e-signature, calendar/contacts server, personal finance, e-book library, translation. | L12 | wave 1 |
| [home](https://github.com/public-software/home) | Home automation hub with Matter, assistant integration, TV/set-top shell, wearables. | L12, L10 | wave 2 |
| [imaging](https://github.com/public-software/imaging) | Raster editor (Graphite raster), vector editor, RAW development, page layout, font editor. | L13 | wave 1 |
| [video](https://github.com/public-software/video) | Video editor (NLE) and compositing / motion graphics. | L13 | wave 3 |
| [audio](https://github.com/public-software/audio) | Digital audio workstation, audio editor, music notation, plugin collection. | L13 | wave 2 |
| [3d](https://github.com/public-software/3d) | 3D content creation suite (Blender-class) and game engine editor (Godot-class on Bevy), XR runtime. | L13, L17 | wave 2 |
| [cad](https://github.com/public-software/cad) | B-rep CAD kernel, parametric CAD application, CAM, meshing. | L14 | wave 1 |
| [engineering](https://github.com/public-software/engineering) | PCB EDA, SPICE, FEA, CFD, systems modelling (Modelica), PLC runtime, SCADA/HMI, DAQ, robotics tooling. | L14 | wave 1 |
| [science](https://github.com/public-software/science) | Numerical computing environment, statistics, computer algebra, notebooks, GIS, medical imaging viewer, bioinformatics, solvers. | L14 | wave 1 |
| [business](https://github.com/public-software/business) | Accounting core, ERP, CRM, billing/e-invoicing, HR & payroll, e-commerce, helpdesk, BI, PLM/MES. | L16 | wave 2 |
| [finance](https://github.com/public-software/finance) | Core banking, trading & market data, account-to-account wallet. | L16 | wave 2 |
| [health](https://github.com/public-software/health) | FHIR-native EHR, LIMS, open clinical terminology. | L16 | wave 1 |
| [civic](https://github.com/public-software/civic) | Rules engine (tax/benefits), rules-as-code corpus tooling, LMS, elections, legal research. | L16 | wave 1 |
| [games](https://github.com/public-software/games) | Win32/DirectX compatibility layer, emulation & preservation, server-authoritative anti-cheat standard + reference, storefront/launcher. | L17 | wave 1 |

### Specs & content

| Repository | Purpose | Layers | Starts |
|---|---|---|---|
| [specs](https://github.com/public-software/specs) | Living specs and executable conformance suites for paywalled or closed standards, and for the suite's own formats. | L18 | wave 1 |
| [content](https://github.com/public-software/content) | Open data the suite depends on: rules-as-code corpus, open clinical terminology, blob-free hardware list, camera RAW profiles, localizations (chart of accounts, tax tables). | L18 | wave 1 |
<!-- catalog:end -->

## How we work
Spec-first cleanroom · `Apache-2.0 OR MIT` · DCO sign-off · RFCs for anything that crosses a repository · GitHub is a mirror of our own forge.

## Sponsors
<!-- sponsors:row -->
