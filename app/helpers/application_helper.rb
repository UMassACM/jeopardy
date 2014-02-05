module ApplicationHelper
	def _markdown(text)
		Redcarpet.new(text).to_html
	end
	def markdown(text)
		markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :autolink => true, :space_after_headers => true, :fenced_code_blocks => true, :lax_spacing => true)
		markdown.render(text).html_safe
	end
end
