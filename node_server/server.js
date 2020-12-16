const express = require('express')
const axios = require('axios')

// App initialization
const app = express()

// Listen
const port = process.env.PORT || 8000

app.listen(port, () => {
  console.log(`Server running on port ${port}`)
})

app.get('/', async (req, res) => {
  const { originLat, originLong, destinationLat, destinationLong } = req.query

  const route =
    'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric'

  const queryOrigins = `&origins=${originLat},${originLong}`
  const queryDestination = `&destinations=${destinationLat},${destinationLong}`
  const APIKey = '&key=AIzaSyCTulmhV9ssSIpWmPX1SiQk-GIlxPLE0Lk'

  const url = route + queryOrigins + queryDestination + APIKey

  try {
    const response = await axios.get(url)
    return res.json(response.data.rows[0].elements[0].duration.value)
  } catch (error) {
    return res
      .status(400)
      .send(
        error.message + ' (' + error.lineNumber + ':' + error.columnNumber + ')'
      )
  }
})
