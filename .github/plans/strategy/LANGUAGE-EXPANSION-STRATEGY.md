# Language Expansion Strategy for AIReady

## 📊 Current State Analysis

### Current Language Support

**Fully Supported (95% market coverage):**
- **TypeScript/JavaScript** (`.ts`, `.tsx`, `.js`, `.jsx`)
- **Python** (`.py`)
- **Java** (`.java`)
- **C#** (`.cs`)
- **Go** (`.go`)

*See [Metric Parity Roadmap](./METRIC-PARITY-ROADMAP.md) for detailed analysis capabilities across these languages.*

---

## 📅 Roadmap (2026-2027)

### Phase 5: High-Performance Systems (Q4 2026) 🦀
**Target Coverage:** +3% market (total: ~98%)
- **Language:** Rust (`.rs`)
- **Focus:** Ownership patterns, Cargo ecosystem, concurrency safety.

### Phase 6: Web & Legacy Extensions (2027+) 📈
**Languages under consideration:**
- **PHP:** Web backends (WordPress, Laravel)
- **Ruby:** Rails ecosystem
- **Kotlin:** Android/Mobile parity
- **Swift:** iOS/macOS ecosystem

---

## 🏗️ Technical Architecture

### Unified Parser Framework
AIReady uses a **hub-and-spoke architecture** powered by `web-tree-sitter`. All language parsers must implement the `LanguageParser` interface in `@aiready/core`:

```typescript
export interface LanguageParser {
  name: string;
  extensions: string[];
  parse(code: string, filePath: string): ParseResult;
  analyzeMetadata(node: SyntaxNode): Metadata;
}
```

### Implementation Principles
1. **AST-First with Regex Fallback:** Always prioritize high-fidelity AST parsing, but maintain robust regex fallbacks for recovery.
2. **Standardized Metadata:** Documentation, visibility, and purity metrics must be mapped to a common format to ensure cross-language metric parity.
3. **Backward Compatibility:** New language additions must never degrade the performance or accuracy of existing TS/JS analysis.

---

## 🎯 Success Metrics
- **Accuracy:** 90%+ parity with language-native linters.
- **Performance:** <60s analysis for 100K LOC polyglot repos.
- **Market Coverage:** Support for top 10 languages by GitHub activity.

**Last Updated:** March 2026  
**Owner:** AIReady Core Team
 toxicology
