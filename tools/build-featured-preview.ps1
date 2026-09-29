Add-Type -AssemblyName System.Drawing

$root = Split-Path -Parent $PSScriptRoot
$output = Join-Path $root 'assets/portfolio-featured.png'
$safeDriver = Join-Path $root 'assets/safedriver.jpg'

$canvas = [System.Drawing.Bitmap]::new(1200, 630)
$graphics = [System.Drawing.Graphics]::FromImage($canvas)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit

function Brush([string]$hex) {
    return [System.Drawing.SolidBrush]::new([System.Drawing.ColorTranslator]::FromHtml($hex))
}

function Font([float]$size, [System.Drawing.FontStyle]$style = [System.Drawing.FontStyle]::Regular) {
    return [System.Drawing.Font]::new('Segoe UI', $size, $style, [System.Drawing.GraphicsUnit]::Pixel)
}

try {
    $navy = Brush '#10252C'
    $ink = Brush '#183038'
    $teal = Brush '#277F7B'
    $cream = Brush '#F4F2EB'
    $white = Brush '#FFFFFF'
    $muted = Brush '#5C7073'
    $graphics.FillRectangle($cream, 0, 0, 1200, 630)
    $graphics.FillRectangle($navy, 620, 0, 580, 630)
    $graphics.FillRectangle($teal, 66, 66, 52, 7)

    $graphics.DrawString('LUCAS PEREIRA', (Font 29 Bold), $teal, 66, 93)
    $graphics.DrawString('Portfólio de', (Font 58 Bold), $ink, 61, 174)
    $graphics.DrawString('análise de dados', (Font 58 Bold), $ink, 61, 239)
    $graphics.DrawString('SQL  ·  Python  ·  Power BI  ·  BigQuery', (Font 24 Regular), $ink, 66, 351)
    $graphics.DrawString('Projetos em saúde, segurança pública', (Font 21 Regular), $muted, 66, 456)
    $graphics.DrawString('e automação de processos', (Font 21 Regular), $muted, 66, 486)
    $graphics.DrawString('lucastastrofe.github.io', (Font 19 Regular), $teal, 66, 565)

    $source = [System.Drawing.Image]::FromFile($safeDriver)
    try {
        $sourceRect = [System.Drawing.Rectangle]::new(0, 35, 1075, 500)
        $targetRect = [System.Drawing.Rectangle]::new(648, 36, 524, 263)
        $graphics.DrawImage($source, $targetRect, $sourceRect, [System.Drawing.GraphicsUnit]::Pixel)
    } finally { $source.Dispose() }
    $safeBand = Brush '#DB10252C'
    $graphics.FillRectangle($safeBand, 648, 215, 524, 84)
    $graphics.DrawString('SafeDriver', (Font 29 Bold), $white, 670, 225)
    $graphics.DrawString('Segurança pública  ·  Python e BigQuery', (Font 17 Regular), $white, 671, 263)

    $vigi = Brush '#DDECE7'
    $graphics.FillRectangle($vigi, 648, 320, 252, 274)
    $graphics.FillRectangle($teal, 672, 348, 42, 5)
    $graphics.DrawString('VigiMed', (Font 29 Bold), $ink, 670, 382)
    $graphics.DrawString('Dados públicos', (Font 18 Regular), $ink, 672, 446)
    $graphics.DrawString('da Anvisa', (Font 18 Regular), $ink, 672, 474)
    $graphics.DrawString('SAÚDE', (Font 16 Bold), $teal, 672, 550)

    $automation = Brush '#E7E5DE'
    $graphics.FillRectangle($automation, 920, 320, 252, 274)
    $graphics.FillRectangle($teal, 944, 348, 42, 5)
    $graphics.DrawString('Monitorar NF', (Font 28 Bold), $ink, 941, 382)
    $graphics.DrawString('Consulta e registro', (Font 18 Regular), $ink, 944, 446)
    $graphics.DrawString('automatizados', (Font 18 Regular), $ink, 944, 474)
    $graphics.DrawString('AUTOMAÇÃO', (Font 16 Bold), $teal, 944, 550)

    $canvas.Save($output, [System.Drawing.Imaging.ImageFormat]::Png)
} finally {
    $graphics.Dispose()
    $canvas.Dispose()
    foreach ($item in @($navy, $ink, $teal, $cream, $white, $muted, $safeBand, $vigi, $automation)) {
        if ($null -ne $item) { $item.Dispose() }
    }
}

Write-Output $output
