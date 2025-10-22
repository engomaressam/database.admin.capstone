# datadump.ps1 - PowerShell script to export sales_data table to SQL file
# This script exports the sales_data table from the sales database to a SQL file

# Database connection parameters
$DB_USER = "root"
$DB_PASSWORD = "PMO@1234"
$DB_NAME = "sales"
$TABLE_NAME = "sales_data"
$OUTPUT_FILE = "sales_data_export.sql"

# MySQL executable path
$MYSQL_PATH = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"

# Export the table to SQL file
Write-Host "Starting export of $TABLE_NAME table from $DB_NAME database..."

# Export table structure
Write-Host "Exporting table structure..."
& $MYSQL_PATH -u $DB_USER -p"$DB_PASSWORD" -e "USE sales; SHOW CREATE TABLE sales_data;" > $OUTPUT_FILE

# Export table data
Write-Host "Exporting table data..."
& $MYSQL_PATH -u $DB_USER -p"$DB_PASSWORD" -e "USE sales; SELECT * FROM sales_data;" >> $OUTPUT_FILE

# Check if export was successful
if (Test-Path $OUTPUT_FILE) {
    $fileSize = (Get-Item $OUTPUT_FILE).Length
    if ($fileSize -gt 0) {
        Write-Host "Export completed successfully!" -ForegroundColor Green
        Write-Host "Data exported to: $OUTPUT_FILE" -ForegroundColor Green
        Write-Host "File size: $([math]::Round($fileSize / 1KB, 2)) KB" -ForegroundColor Green
        
        # Show first few lines of the export file
        Write-Host "`nFirst few lines of the export file:" -ForegroundColor Yellow
        Get-Content $OUTPUT_FILE | Select-Object -First 5
    } else {
        Write-Host "Export failed - output file is empty!" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Export failed - output file not created!" -ForegroundColor Red
    exit 1
}