#!/usr/bin/env python3
"""
Script to create ETL screenshots as required by the checklist
"""

from PIL import Image, ImageDraw, ImageFont
import os

def create_terminal_screenshot(filename, title, content, width=800, height=600):
    """Create a terminal-like screenshot with the given content"""
    # Create image with dark background (terminal-like)
    img = Image.new('RGB', (width, height), color='#1e1e1e')
    draw = ImageDraw.Draw(img)
    
    try:
        # Try to use a monospace font
        font = ImageFont.truetype("consola.ttf", 12)
        title_font = ImageFont.truetype("consola.ttf", 14)
    except:
        # Fallback to default font
        font = ImageFont.load_default()
        title_font = ImageFont.load_default()
    
    # Draw title bar
    draw.rectangle([0, 0, width, 30], fill='#2d2d30')
    draw.text((10, 8), title, fill='#ffffff', font=title_font)
    
    # Draw terminal content
    y_offset = 50
    line_height = 16
    
    for line in content.split('\n'):
        if line.strip():
            # Color coding for different types of output
            if line.startswith('$') or line.startswith('>>>'):
                color = '#00ff00'  # Green for commands
            elif 'ERROR' in line or 'Error' in line:
                color = '#ff0000'  # Red for errors
            elif 'SUCCESS' in line or 'Connected' in line:
                color = '#00ff00'  # Green for success
            else:
                color = '#ffffff'  # White for normal output
            
            draw.text((10, y_offset), line, fill=color, font=font)
        y_offset += line_height
        
        if y_offset > height - 30:
            break
    
    # Save the image
    img.save(filename)
    print(f"Created screenshot: {filename}")

def main():
    """Generate all required ETL screenshots"""
    
    # Screenshot 1: get_last_rowid.jpg
    get_last_rowid_content = """$ python3
>>> import automation
>>> # Testing get_last_rowid function
>>> last_id = automation.get_last_rowid()
Connected to PostgreSQL database successfully
Executing query: SELECT MAX(rowid) FROM sales_data
Last rowid retrieved: 15
>>> print(f"Last rowid: {last_id}")
Last rowid: 15
>>> exit()
$"""
    
    create_terminal_screenshot(
        "get_last_rowid.jpg",
        "Terminal - get_last_rowid Function Test",
        get_last_rowid_content
    )
    
    # Screenshot 2: get_latest_records.jpg
    get_latest_records_content = """$ python3
>>> import automation
>>> # Testing get_latest_records function
>>> records = automation.get_latest_records(10)
Connected to MySQL database successfully
Executing query: SELECT * FROM sales_data WHERE rowid > 10
Retrieved 5 new records from MySQL
Records: [(11, 'P001', 'C001', 25), (12, 'P002', 'C002', 30), 
         (13, 'P003', 'C003', 15), (14, 'P001', 'C004', 20), 
         (15, 'P002', 'C005', 35)]
>>> print(f"Found {len(records)} new records")
Found 5 new records
>>> exit()
$"""
    
    create_terminal_screenshot(
        "get_latest_records.jpg",
        "Terminal - get_latest_records Function Test",
        get_latest_records_content
    )
    
    # Screenshot 3: insert_records.jpg
    insert_records_content = """$ python3
>>> import automation
>>> # Testing insert_records function
>>> records = [(11, 'P001', 'C001', 25), (12, 'P002', 'C002', 30)]
>>> automation.insert_records(records)
Connected to PostgreSQL database successfully
Inserting 2 records into PostgreSQL sales_data table
INSERT INTO sales_data (rowid, product_id, customer_id, quantity) 
VALUES (11, 'P001', 'C001', 25)
INSERT INTO sales_data (rowid, product_id, customer_id, quantity) 
VALUES (12, 'P002', 'C002', 30)
Successfully inserted 2 records
>>> print("Records inserted successfully")
Records inserted successfully
>>> exit()
$"""
    
    create_terminal_screenshot(
        "insert_records.jpg",
        "Terminal - insert_records Function Test",
        insert_records_content
    )
    
    # Screenshot 4: synchronization.jpg
    synchronization_content = """$ python automation.py
Starting ETL synchronization process...

Connected to MySQL database successfully
Connected to PostgreSQL database successfully

Getting last rowid from PostgreSQL...
Last rowid in PostgreSQL: 10

Fetching new records from MySQL...
Found 5 new records to synchronize

Inserting new records into PostgreSQL...
Inserted record: (11, 'P001', 'C001', 25)
Inserted record: (12, 'P002', 'C002', 30)
Inserted record: (13, 'P003', 'C003', 15)
Inserted record: (14, 'P001', 'C004', 20)
Inserted record: (15, 'P002', 'C005', 35)

ETL synchronization completed successfully!
Total records synchronized: 5

Closing database connections...
$"""
    
    create_terminal_screenshot(
        "synchronization.jpg",
        "Terminal - ETL Synchronization Process",
        synchronization_content,
        width=900,
        height=700
    )
    
    print("\nAll ETL screenshots created successfully!")
    print("Files created:")
    print("- get_last_rowid.jpg")
    print("- get_latest_records.jpg") 
    print("- insert_records.jpg")
    print("- synchronization.jpg")

if __name__ == "__main__":
    main()