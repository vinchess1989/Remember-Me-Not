import os
import glob

slides_dir = 'slides'

if not os.path.exists(slides_dir):
    print(f"Directory '{slides_dir}' not found.")
    exit()

html_files = glob.glob(os.path.join(slides_dir, '*.html'))

for html_file in html_files:
    base_name = os.path.basename(html_file)
    js_name = base_name.replace('.html', '.js')
    js_file = os.path.join(slides_dir, js_name)
    js_key = f"slides/{js_name}"
    
    with open(html_file, 'r', encoding='utf-8') as f:
        content = f.read()
        
    # Escape backticks and template literals so they don't break the JS string
    content = content.replace('`', '\\`').replace('${', '\\${')
    
    js_content = f"window.presentationSlides = window.presentationSlides || {{}};\nwindow.presentationSlides['{js_key}'] = `\n{content}`;\n"
    
    with open(js_file, 'w', encoding='utf-8') as f:
        f.write(js_content)
        
    print(f"Converted {base_name} to {js_name}")

print("\nConversion complete! Your wrapper should now load perfectly.")