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
  const {
    originLat,
    originLong,
    destinationLat,
    destinationLong,
    showAll,
  } = req.query

  // console.log('originLat: ', originLat)
  // console.log('originLong: ', originLong)
  // console.log('destinationLat: ', destinationLat)
  // console.log('destinationLong: ', destinationLong)

  const route =
    'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric?'

  const queryOrigins = `&origins=${originLat},${originLong}`
  const queryDestination = `&destinations=${destinationLat},${destinationLong}`
  const APIKey = '&key=AIzaSyCTulmhV9ssSIpWmPX1SiQk-GIlxPLE0Lk'

  const url = route + queryOrigins + queryDestination + APIKey
  // console.log('url: ', url)

  try {
    const response = await axios.get(url)
    if (showAll) {
      return res.json(response.data)
    }

    return res.json(response.data.rows[0].elements[0].duration.value)
  } catch (error) {
    return res.status(400).send(error.message)
  }
})

app.get('/directions', async (req, res) => {
  const {
    originLat,
    originLong,
    destinationLat,
    destinationLong,
    elapsed,
    coordinate,
  } = req.query

  // console.log('originLat: ', originLat)
  // console.log('originLong: ', originLong)
  // console.log('destinationLat: ', destinationLat)
  // console.log('destinationLong: ', destinationLong)

  const route = 'https://maps.googleapis.com/maps/api/directions/json?'

  const queryOrigins = `origin=${originLat},${originLong}`
  const queryDestination = `&destination=${destinationLat},${destinationLong}`
  const APIKey = '&key=AIzaSyCTulmhV9ssSIpWmPX1SiQk-GIlxPLE0Lk'

  const url = route + queryOrigins + queryDestination + APIKey
  // console.log('url: ', url)

  try {
    const response = await axios.get(url)

    const data = response.data

    const steps = response.data.routes[0].legs[0].steps

    const numSteps = steps.length

    const filteredSteps = steps.map(element => ({
      distance: element.distance,
      duration: element.duration,
      start_location: element.start_location,
      end_location: element.end_location,
    }))

    const duration = response.data.routes[0].legs[0].duration.value

    console.log('--------------- elapsed:', elapsed)
    console.log('duration:', duration)
    console.log('%:', (elapsed / duration) * 100)
    console.log('numSteps:', numSteps)

    const currentStepIndex =
      Math.floor((elapsed / duration) * numSteps) >= numSteps
        ? numSteps - 1
        : Math.floor((elapsed / duration) * numSteps)

    console.log('currentStepIndex:', currentStepIndex)

    const startLocation = steps[currentStepIndex].start_location

    if (coordinate === 'lng') return res.send(`${startLocation.lng}`)

    return res.send(`${startLocation.lat}`)
  } catch (error) {
    return res.status(400).send(error.message)
  }
})
