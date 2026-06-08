# BibleAnalysis

Local Scripture research workspace centered on learning more about Jesus Christ and seeking truth carefully.

## Contents

- `resources/` - downloaded public Bible text files and translation metadata
- `tools/` - local helper scripts for comparison and analysis
- `agent_learning/` - durable notes, corpus observations, and study records

## Current Tools

Compare a tab-separated verse across available translations:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File C:\Bible\tools\compare_verse.ps1 "John 1:1"
```

## Current Baselines

- Translation manifest: `resources/translation_manifest.csv`
- Protestant/public-domain trust ranking: `resources/protestant_trust_ranking.md`
- Project orientation: `agent_learning/project_brief.md`
