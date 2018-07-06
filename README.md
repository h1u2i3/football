# README

core code:

```ruby
  def schedule
    @teams = Team.all
    if @teams.size == 16
      @schedules = []
      time_index = 0
      @teams.each_slice(4) do |slice|
        times = avail_times[time_index..(time_index + 1) * 6 - 1]
        new_schedule_teams = []
        schedule_teams = slice.combination(2).to_a
        (0..5).each do |i|
          new_schedule_teams << (schedule_teams[i] << times[i])
        end
        @schedules << new_schedule_teams
        time_index = time_index + 1
      end
    else
      @error = "Sorry, team size is not 16, please make sure the team size is equal to 16"
    end
    if @error
      render json: {error: @error}
    end
  end
```

1. push with http://localhost:3000/teams.json

```json
{
  "team": {
    "name": "China"
  }
}
```

result:

```json
{
    "id": 17,
    "name": "dsadjasl",
    "created_at": "2018-07-06T09:19:09.848Z",
    "updated_at": "2018-07-06T09:19:09.848Z",
    "url": "http://localhost:3000/teams/17.json"
}
```

2. 生成 JSON 时，如果 Team 数量不足 16，则报错，如果数量为16，则生成相应的结果。

http://localhost:3000/schedule.json

```json
[
    {
        "teamA": "1_team",
        "teamB": "2_team",
        "time": "2018-07-06T21:00:00.000Z"
    },
    {
        "teamA": "1_team",
        "teamB": "3_team",
        "time": "2018-07-06T23:00:00.000Z"
    },
    {
        "teamA": "1_team",
        "teamB": "4_team",
        "time": "2018-07-07T21:00:00.000Z"
    },
    {
        "teamA": "2_team",
        "teamB": "3_team",
        "time": "2018-07-07T23:00:00.000Z"
    },
    {
        "teamA": "2_team",
        "teamB": "4_team",
        "time": "2018-07-08T21:00:00.000Z"
    },
  ...
]
```