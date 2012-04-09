Time =
  from: ->
    time = Math.floor(time || 0)
    date = new Date(time * 1000)

    minutes = ("0" + date.getMinutes()).slice(-2)
    seconds = ("0" + date.getSeconds()).slice(-2)

    "#{minutes}:#{seconds}"

window.Time = Time