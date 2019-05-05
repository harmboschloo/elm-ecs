call elm make Main.elm --output=index-elm.html --optimize
call html-minifier --minify-js true index-elm.html > index.html
