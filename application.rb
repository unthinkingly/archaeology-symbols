require "sinatra"

generated_file="views/generated.erb"
header_pattern=/###/

def to_classnames(a_string)
  a_string.strip.gsub("=", " ").gsub(":", " ")
end

def to_file_name(a_string)
  a_string.strip.gsub("=", "_").gsub(":", "_")
end

def to_title(a_string)
  
end
get "/generate" do # create and read the generated file
  
  File.delete(generated_file)
  
  open(generated_file, "a+") do |file|
    input = File.open("symbols.markdown", "r").readlines
    input.each do |l|
      unless l.empty? or l =="\n"
        if (l =~ header_pattern)
          file << "<h2>"  + l.gsub(header_pattern, "").strip + "</h2>" + "\n"
        else
          file << "<div class='item " + to_classnames(l) + "'>"  + "<img src='#{to_file_name(l)}' /> <a>" + l.strip + "</a></div>" + "\n"
        end
      end
    end
  end
  
  erb :generated
end

get "/" do # read the generated file
  erb :generated
end