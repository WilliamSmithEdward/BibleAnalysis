param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Reference,

    [string]$ResourcesDir = "C:\Bible\resources",

    [string]$ManifestPath = "C:\Bible\resources\translation_manifest.csv"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $ResourcesDir)) {
    throw "Resources directory not found: $ResourcesDir"
}

if (Test-Path -LiteralPath $ManifestPath) {
    $manifest = Import-Csv -LiteralPath $ManifestPath
} else {
    $manifest = Get-ChildItem -LiteralPath $ResourcesDir -Filter "*.txt" | ForEach-Object {
        [pscustomobject]@{
            file = $_.Name
            short_name = [IO.Path]::GetFileNameWithoutExtension($_.Name).ToUpperInvariant()
            translation = $_.Name
            trust_score = 0
            priority_tier = "unknown"
        }
    }
}

$escapedReference = [regex]::Escape($Reference)
$pattern = "^$escapedReference`t(.+)$"

$skipped = @()

$results = foreach ($item in $manifest) {
    $path = Join-Path $ResourcesDir $item.file
    if (-not (Test-Path -LiteralPath $path)) {
        continue
    }

    if ($item.PSObject.Properties.Name -contains "lookup_format" -and $item.lookup_format -ne "tab_verse") {
        $skipped += "$($item.short_name) ($($item.file): $($item.lookup_format))"
        continue
    }

    $match = Select-String -LiteralPath $path -Pattern $pattern -CaseSensitive | Select-Object -First 1
    if ($match) {
        [pscustomobject]@{
            Score = [int]$item.trust_score
            Version = $item.short_name
            File = $item.file
            Translation = $item.translation
            Text = $match.Matches[0].Groups[1].Value
        }
    }
}

if (-not $results) {
    Write-Output "No verse found for reference: $Reference"
    exit 1
}

$table = $results |
    Sort-Object @{ Expression = "Score"; Descending = $true }, Version |
    Format-Table -AutoSize -Wrap |
    Out-String -Width 220

Write-Output $table.TrimEnd()

if ($skipped.Count -gt 0) {
    Write-Output ""
    Write-Output "Skipped non-tab verse files: $($skipped -join ', ')"
}
