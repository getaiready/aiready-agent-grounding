# Metric Parity Roadmap

This document tracks the progress of expanding AIReady's advanced metrics beyond TypeScript/JavaScript and Python to achieve full parity across all supported languages (Java, C#, Go).

## Current Support Matrix (Q1 2026)

| Metric | TS/JS | Python | Java | C# | Go | Status |
| :--- | :---: | :---: | :---: | :---: | :---: | :--- |
| **Export/Import Extraction** | ✅ | ✅ | ✅ | ✅ | ✅ | Full Parity |
| **Purity & Side-Effects** | ✅ | ✅ | ✅ | ✅ | ✅ | Full Parity |
| **Documentation (Doc/JSDoc)** | ✅ | ✅ | ✅ | ✅ | ✅ | Full Parity |
| **Pattern Detection** | ✅ | ✅ | ✅ | ✅ | ✅ | Full Parity |
| **Context Analysis** | ✅ | ✅ | ✅ | ✅ | ✅ | Full Parity |
| **Naming Consistency** | ✅ | ✅ | ✅ | ✅ | ✅ | Full Parity |
| **Change Amplification**| ✅ | ✅ | ✅ | ✅ | ✅ | Full Parity |

---

## 🚀 Phase 5: Metric Parity Roadmap

### Phase 5.1: Infrastructure Generalization (The "Common AST" Layer)
**Goal:** Abstract spoke logic away from specific AST formats (ESTree vs. Tree-sitter).

- [ ] **@aiready/core**: Extend `LanguageParser` interface to provide higher-level query methods:
  - `findDeclarations()` -> Standardized set of functions/classes/interfaces.
  - `query(selector: string)` -> Tree-sitter query support for custom signals.
  - `analyzePurity(node)` -> Common logic for side-effect detection.
- [ ] **@aiready/core**: Implement `CommonAST` adapter to wrap Tree-sitter nodes in a consistent interface.

---

## Progress Tracking

- [x] Phase 1-4: Multi-Language AST Foundation (Python, Java, C#, Go) - **COMPLETE**
- [x] Phase 5: Metric Parity & AST Generalization - **COMPLETE**
- [/] Phase 6: Final Documentation & Documentation Consolidation - **IN PROGRESS**
