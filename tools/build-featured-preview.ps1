Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$output = Join-Path $root 'assets/portfolio-featured-v2.png'
$canvas = [System.Drawing.Bitmap]::new(1200, 630)
$graphics = [System.Drawing.Graphics]::FromImage($canvas)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

function Brush([string]$hex) {
    [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml($hex))
}

function Font([float]$size, [System.Drawing.FontStyle]$style = [System.Drawing.FontStyle]::Regular) {
    [System.Drawing.Font]::new('Segoe UI', $size, $style, [System.Drawing.GraphicsUnit]::Pixel)
}

$navy = Brush '#10272E'
$cream = Brush '#F5F1E9'
$white = Brush '#FFFFFF'
$teal = Brush '#6FE0CF'
$ink = Brush '#173039'
$muted = Brush '#4C686C'
$line = Brush '#B9C9C6'

try {
    $graphics.FillRectangle($navy, 0, 0, 770, 630)
    $graphics.FillRectangle($cream, 770, 0, 430, 630)
    $graphics.FillRectangle($teal, 64, 64, 58, 8)

    $graphics.DrawString('LUCAS PEREIRA', (Font 43 Bold), $white, 59, 102)
    $graphics.DrawString('ANALISTA', (Font 83 Bold), $white, 55, 204)
    $graphics.DrawString('DE DADOS', (Font 83 Bold), $white, 55, 297)
    $graphics.DrawString('SQL  ·  Python  ·  Power BI', (Font 31 Regular), $teal, 64, 448)
    $graphics.DrawString('PORTFÓLIO DE PROJETOS', (Font 24 Regular), $white, 64, 562)

    $graphics.DrawString('PROJETOS', (Font 28 Bold), $muted, 810, 65)
    $graphics.FillRectangle($line, 810, 123, 350, 2)
    $graphics.DrawString('SafeDriver', (Font 45 Bold), $ink, 808, 157)
    $graphics.DrawString('Segurança pública', (Font 24 Regular), $muted, 811, 214)
    $graphics.FillRectangle($line, 810, 273, 350, 2)
    $graphics.DrawString('VigiMed', (Font 45 Bold), $ink, 808, 306)
    $graphics.DrawString('Saúde', (Font 24 Regular), $muted, 811, 363)
    $graphics.FillRectangle($line, 810, 421, 350, 2)
    $graphics.DrawString('Monitorar NF', (Font 43 Bold), $ink, 808, 454)
    $graphics.DrawString('Automação', (Font 24 Regular), $muted, 811, 511)
    $graphics.FillRectangle($line, 810, 574, 350, 2)

    $canvas.Save($output, [System.Drawing.Imaging.ImageFormat]::Png)
} finally {
    $graphics.Dispose()
    $canvas.Dispose()
    foreach ($item in @($navy, $cream, $white, $teal, $ink, $muted, $line)) {
        $item.Dispose()
    }
}

Write-Output $output
