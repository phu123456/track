namespace :delete do
  desc 'Delete records older than 10 days'
  task :old_records => :environment do
      Position.delete_all('created_at < ?', 15.days.ago)
  end
end
