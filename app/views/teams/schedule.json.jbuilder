json.array! @schedules.flatten(1) do |schedule|
  json.teamA schedule[0].name
  json.teamB schedule[1].name
  json.time schedule[2]
end
