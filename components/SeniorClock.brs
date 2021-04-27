function init()
  m.top.backgroundURI = ""
  m.top.backgroundColor = &h00000000

  m.updateTimer = m.top.findNode("updateTimer")
  m.updateTimer.control = "start"
  m.updateTimer.ObserveField("fire", "updateScreen")

  m.myDayName = m.top.findNode("myDayName")
  m.myTimeDescription = m.top.findNode("myTimeDescription")
  m.myTime = m.top.findNode("myTime")
  m.myMonth = m.top.findNode("myMonth")
  m.myDay = m.top.findNode("myDay")
  m.myYear = m.top.findNode("myYear")

  'Set the font size
  m.myDayName.font.size = 128
  m.myTimeDescription.font.size = 92
  m.myTime.font.size = 256
  m.myMonth.font.size = 92
  m.myDay.font.size = 92
  m.myYear.font.size = 92

  'Set the text color
  m.myDayName.color = "&hFFFFFFFF"
  m.myTimeDescription.color = "&hFFFFFFFF"
  m.myTime.color = "&hFFFFFFFF"
  m.myMonth.color = "&hFFFFFFFF"
  m.myDay.color = "&hFFFFFFFF"
  m.myYear.color = "&hFFFFFFFF"

  m.lastMinute = -1

  m.monthName = CreateObject("roArray", 12, false)
  m.monthName = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

  m.top.setFocus(true)

  m.updateAll = true
  updateScreen()

end function

function updateScreen()
  date = CreateObject("roDateTime")
  date.ToLocalTime()
  currentMinute = date.getMinutes()

  if currentMinute <> m.lastMinute then
    if currentMinute = 0 then m.updateAll = true

    if m.updateAll = true then
      if date.getHours() > 12 then
        hoursString = Str(date.getHours() - 12).Trim()
        ampm = "pm"
        if date.getHours() > 18 then
          timeOfDay = "Night"
        else
          timeOfDay = "Afternoon"
        end if
      else
        if date.getHours() = 0 then hoursString = "12" else hoursString = Str(date.getHours()).Trim()
        ampm = "am"
        timeOfDay = "Morning"
      end if

      m.myDayName.text = date.GetWeekday()
      m.myTimeDescription.text = timeOfDay

      '** Spell out the Month
      m.myMonth.text = m.monthName[date.GetMonth() - 1]

      m.myDay.text = date.getDayOfMonth()
      m.myYear.text = date.GetYear()
    end if

    if currentMinute < 10 then
      minuteString = "0" + Str(currentMinute).Trim()
    else
      minuteString = Str(currentMinute).Trim()
    end if


    '** Display Day of Week and Time of Day
    m.myTime.text = hoursString + ":" + minuteString + " " + ampm
    m.lastMinute = currentMinute
  end if

end function