require 'json'
JSON.parse(%x[i3-msg -t get_workspaces]).each do |workspace|
    if (workspace['focused']) then
        number = workspace['name'].split(/:/)[0]

        if (ARGV[0].chomp == "workspace") then
            new_name = "#{number}"
        else
            new_name = "#{number}: #{ARGV[0].chomp}"
        end

        %x[i3-msg 'rename workspace "#{workspace['name']}" to "#{new_name}"']
    end
end
