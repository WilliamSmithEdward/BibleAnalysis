# Corpus Observations

## Downloaded Public Texts

The downloaded text files live in `C:\Bible\resources`.

Initial observation: most files are line-based, with a short header followed by tab-separated verse lines:

```text
Book Chapter:Verse<TAB>Verse text
```

Examples:

- `kjv.txt` begins with `KJV` and a source note, then `Genesis 1:1`.
- `bsb.txt` begins with Berean source/public-domain notes, then a `Verse` header.
- `jps.txt` begins with `JPS / WEY` and `JPS Tanakh 1917 OT / Weymouth NT`.

## Important Correction

`jps.txt` should not be treated as only the JPS 1917 Tanakh. In this Open Bible download set, the file includes:

- Old Testament: JPS Tanakh 1917
- New Testament: Weymouth New Testament

The Protestant trust ranking was corrected to reflect this combined OT/NT file.

## Download Integrity

The original `web.txt` download was partial because the first batch timed out. It ended in Luke 3:9. A later audit compared local file sizes against remote `Content-Length` headers and found only `web.txt` mismatched. It was re-downloaded from Open Bible and now ends at Revelation 22:21.

## Lookup Formats

Most files use tab-separated verse lines and can be searched by exact reference. `brb.txt` is different: it is formatted as a reader's Bible with chapter headings and prose lines, not explicit `Book Chapter:Verse<TAB>Text` records. Treat it as a smooth reading text unless a chapter-reader parser is added.

## Trust Baseline

The current Protestant/public-domain trust baseline is saved at:

```text
C:\Bible\resources\protestant_trust_ranking.md
```

The ranking is a starting heuristic, not a truth oracle. It should be revised when corpus facts, source provenance, or translation history warrant it.
