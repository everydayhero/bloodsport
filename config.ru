run ->(env) do
  ["200", {"Content-Type" => "text/html"}, ["<pre>#{ENV.to_h}</pre>"]]
end
