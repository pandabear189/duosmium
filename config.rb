# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

Dir.new(Pathname.new(__dir__) + 'data')
  .children
  .map { |f| f.delete_suffix(".yaml") }
  .each do |t|
  proxy "/results/#{t}.html", "/results/template.html",
    locals: { tournament: t }, ignore: true
end

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def find_logo_path(filename)
    image_dir = Dir.new(Pathname.new(__dir__) + 'source' + 'images' + 'logos')
    potential_logos = [
      filename + '.png',
      filename + '.jpg',
      filename.split('_')[0..-2].join('_') + '.png', # remove _b or _c suffix
      filename.split('_')[0..-2].join('_') + '.jpg', # remove _b or _c suffix
      filename.split('_')[1..-2].join('_') + '.png', # remove date as well
      filename.split('_')[1..-2].join('_') + '.jpg'  # remove date as well
    ]
    potential_logos.concat(%w[
      default.jpg
    ].shuffle)
    '/images/logos/' + potential_logos.find { |l| image_dir.children.include? l }
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
