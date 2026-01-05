# Gallery Generator System

This folder contains an automated gallery generator that creates photo galleries from all images in the `gallery/` directory.

## Files

### Templates (Don't edit these directly!)
- **index-template.html** - Template for the main page with carousel gallery
- **gallery-template.html** - Template for the full gallery page

### Generation Script
- **generate_galleries.sh** - Generates BOTH index.html and gallery.html in one go

### Generated Files (Auto-created by script)
- **index.html** - Main page with carousel gallery
- **gallery.html** - Full gallery page with grid layout

## How to Use

### When Adding New Photos

Whenever you add new photos to the `gallery/` folder, simply run:

```bash
./generate_galleries.sh
```

This single command:
- Scans all images in `gallery/` directory
- Generates `index.html` with carousel containing ALL images
- Generates `gallery.html` with grid of ALL images
- **Keeps the same image order in both files**

### What the Script Does

The unified script:
- Scans the gallery folder once for all JPG/PNG images
- Generates carousel items for index.html (shows 2-4 at a time)
- Generates grid items for gallery.html (shows all at once)
- Ensures identical image order in both galleries
- Provides a summary of what was generated

### Supported Formats

- JPG/JPEG
- PNG

### Features

**Main Page Carousel (index.html):**
- Shows 4 images at once on desktop
- Shows 3 images at once on tablet
- Shows 2 images at once on mobile
- Navigation arrows to scroll through all images
- Click to zoom with lightbox

**Full Gallery Page (gallery.html):**
- Responsive grid layout
- Lightbox zoom on click
- All images displayed at once

## Current Status

- **Total Images:** 95
- **Last Generated:** Check timestamps on `index.html` and `gallery.html`

## Customizing

To change layouts or styling:

1. **For main page:** Edit `index-template.html`
2. **For gallery page:** Edit `gallery-template.html`
3. Run the appropriate script(s) to regenerate

The scripts preserve your template changes and insert all current gallery images.
