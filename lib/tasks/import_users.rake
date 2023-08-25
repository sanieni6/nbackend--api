namespace :import do
    desc "Import users from JSON file"
    task users: :environment do
        file_path = Rails.root.join('users.json')
        users_data = JSON.parse(File.read(file_path))
        users = users_data['users']

        users.each do |user|
            filtered_data = {
                firstname: user['firstName'],
                lastname: user['lastName'],
                age: user['age'],
                email: user['email'],
                image: user['image']
            }
            User.create(filtered_data)
        end
        puts "Imported #{users_data.length} users."
    end
end