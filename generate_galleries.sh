#!/bin/bash

# Unified script to generate both index.html and gallery.html
# with all images from the gallery directory in the same order

GALLERY_DIR="gallery"
INDEX_TEMPLATE="index-template.html"
GALLERY_TEMPLATE="gallery-template.html"
INDEX_OUTPUT="index.html"
GALLERY_OUTPUT="gallery.html"

echo "Generating gallery pages..."

# Check if gallery directory exists
if [ ! -d "$GALLERY_DIR" ]; then
    echo "Error: Gallery directory not found!"
    exit 1
fi

# Check if templates exist
if [ ! -f "$INDEX_TEMPLATE" ]; then
    echo "Error: Index template not found!"
    exit 1
fi

if [ ! -f "$GALLERY_TEMPLATE" ]; then
    echo "Error: Gallery template not found!"
    exit 1
fi

# Counter for images
count=0

# Process all image files ONCE and generate both carousel and grid items
find "$GALLERY_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) | sort | while read -r img; do
    # Get filename without path
    filename=$(basename "$img")

    # Generate alt text from filename (remove extension and replace special chars)
    alt_text=$(echo "$filename" | sed 's/\.[^.]*$//' | sed 's/[-_]/ /g')

    # Generate carousel item (for index.html)
    echo "                        <div class=\"gallery-item\">"
    echo "                            <img src=\"$img\" alt=\"Zoloti Maky - $alt_text\">"
    echo "                        </div>"

    ((count++))
done > /tmp/gallery_carousel_items.txt

# Copy the same content for the grid layout (gallery.html)
# Just change the indentation to match gallery-template.html
sed 's/^                        /                /' /tmp/gallery_carousel_items.txt > /tmp/gallery_grid_items.txt

# Read the generated items
count=$(wc -l < /tmp/gallery_carousel_items.txt)
count=$((count / 3))  # Each item is 3 lines

# Check if any images were found
if [ $count -eq 0 ]; then
    echo "Warning: No images found in $GALLERY_DIR directory"
else
    echo "Found $count images"
fi

# Generate index.html
echo "Generating $INDEX_OUTPUT..."
awk '
/<!-- GALLERY_CAROUSEL_ITEMS_PLACEHOLDER -->/ {
    system("cat /tmp/gallery_carousel_items.txt")
    next
}
{ print }
' "$INDEX_TEMPLATE" > "$INDEX_OUTPUT"

# Generate gallery.html
echo "Generating $GALLERY_OUTPUT..."
awk '
/<!-- GALLERY_ITEMS_PLACEHOLDER -->/ {
    system("cat /tmp/gallery_grid_items.txt")
    next
}
{ print }
' "$GALLERY_TEMPLATE" > "$GALLERY_OUTPUT"

# Cleanup
rm -f /tmp/gallery_carousel_items.txt
rm -f /tmp/gallery_grid_items.txt

echo ""
echo "✓ Gallery pages generated successfully!"
echo "  - $INDEX_OUTPUT (carousel with $count images)"
echo "  - $GALLERY_OUTPUT (grid with $count images)"
echo "  - Image order is identical in both files"
