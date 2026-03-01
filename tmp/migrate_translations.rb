Experience.find_each do |e|
  Mobility.with_locale(:fr) do
    e.job_title = e.read_attribute(:job_title)
    e.missions  = e.read_attribute(:missions)
    e.tools     = e.read_attribute(:tools)
    e.save
  end
end

Project.find_each do |p|
  Mobility.with_locale(:fr) do
    p.name        = p.read_attribute(:name)
    p.description = p.read_attribute(:description)
    p.save
  end
end

puts "FR data migrated: #{Experience.count} experiences, #{Project.count} projects"
