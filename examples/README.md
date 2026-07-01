# Sample projects for REFINE

## Quick try (included)

| Project | Path | What to expect |
|---------|------|----------------|
| **Calculator demo** | `examples/sample-java-repo/` | Small Maven project with intentional smells (long method, god class, data clumps). Best first upload. |

```bash
cd examples/sample-java-repo
zip -r ../sample-java-repo.zip .
```

In the REFINE UI: **Project Hub → Upload** → select `sample-java-repo.zip` → run **Analyze** → open a file in **AI Refactoring**.

## Recommended open-source Java systems

REFINE works on real Maven/Gradle/Ant workspaces uploaded as ZIP archives or cloned from Git. The table below lists **15 widely used OSS Java systems** that are representative for smell detection and refactoring experiments (libraries, tools, and applications).

| Project | Type | Scale | KLOC* | Good starting point? | Source |
|---------|------|-------|------:|:--------------------:|--------|
| **JUnit 4** | Testing framework | Small | 20 | ✅ | [junit-team/junit4](https://github.com/junit-team/junit4) |
| **SLF4J** | Logging facade | Small | 20 | ✅ | [qos-ch/slf4j](https://github.com/qos-ch/slf4j) |
| **jsoup** | HTML parser | Small | 29 | ✅ | [jhy/jsoup](https://github.com/jhy/jsoup) |
| **Mockito** | Mocking framework | Medium | 48 | ✅ | [mockito/mockito](https://github.com/mockito/mockito) |
| **Logback** | Logging framework | Medium | 59 | | [qos-ch/logback](https://github.com/qos-ch/logback) |
| **GanttProject** | Project management | Medium | 86 | | [bardsoftware/ganttproject](https://github.com/bardsoftware/ganttproject) |
| **JHotDraw** | GUI framework | Medium | 122 | | [werner-duvaud/jhotdraw](https://github.com/werner-duvaud/jhotdraw) |
| **Checkstyle** | Static analysis tool | Large | 188 | | [checkstyle/checkstyle](https://github.com/checkstyle/checkstyle) |
| **JEdit** | Text editor | Medium–large | 193 | | [RMTT/jEdit](https://github.com/RMTT/jEdit) |
| **Eclipse Collections** | Collections library | Medium–large | 214 | | [eclipse/eclipse-collections](https://github.com/eclipse/eclipse-collections) |
| **Apache Ant** | Build tool | Medium–large | 239 | | [apache/ant](https://github.com/apache/ant) |
| **Apache Xerces-J** | XML parser | Medium–large | 297 | | [apache/xerces2-j](https://github.com/apache/xerces2-j) |
| **ArgoUML** | UML modeling | Medium–large | 332 | | [argouml/argouml](https://github.com/argouml/argouml) |
| **Guava** | Core utilities | Large | 475 | | [google/guava](https://github.com/google/guava) |
| **JabRef** | Reference manager | Large | 516 | | [JabRef/jabref](https://github.com/JabRef/jabref) |

\*KLOC = thousands of lines of production Java source (test paths excluded). Figures are indicative scale guides for choosing a workspace size.

### How to use an external project

1. Clone or download the repository (pin a release tag for reproducibility).
2. Create a ZIP of the project root (or use **Clone from Git** in Project Hub if available).
3. Upload in **Project Hub** — each ZIP becomes one workspace.
4. Run **PMD analysis** on the workspace before refactoring.
5. Start with **one file** in AI Refactoring, then scale to **Batch Refactor** when comfortable.

**Tips**

- Prefer **production `src/main/java`** files first; test-only files are optional.
- Large projects (Guava, JabRef, Checkstyle) take longer to index and analyze — start with SLF4J, JUnit, or jsoup.
- You do not need a green `mvn test` for every file; REFINE focuses on static analysis and refactor evidence, not full CI integration.
