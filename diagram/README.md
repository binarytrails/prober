# Diagram

## Mermaid.js

```mermaid
graph LR
    A[External] -->|Initial Access| B{Target}
    B -->|Access| C[Machine]
    C -->|Connect| D1[/Service\]
    C -->|Connect| D2[(Database)]
    B -->|Access| C2[Desktop]
```

> https://github.com/mermaid-js/mermaid-cli

Resources:
- https://mermaid.live/
- https://mermaid-js.github.io/mermaid/#/
- https://developpaper.com/how-to-get-started-with-writing/
- https://github.blog/2022-02-14-include-diagrams-markdown-files-mermaid/
