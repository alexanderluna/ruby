video_list = []

video_list.each do |link|
	puts "\nDownloading: \t#{link}\n"
	system("youtube-dl #{link}")
end
