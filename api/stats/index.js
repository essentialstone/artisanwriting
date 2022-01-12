import express from 'express'
import bodyParser from 'body-parser'
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()
const app = express()

app.use(express.json())
app.use(bodyParser.json())

function getNumber(str) {
  const i = parseInt(str)
  if (isNaN(i)) {
    return null
  }
  if (`${i}` !== str) {
    return null
  }
  return i
}

app.get('/ratings', async (req, res) => {
  const ratings = await prisma.rating.findMany({
    include: {
      rater: true,
      sentence: {
        include: {
          source: true,
        },
      },
      tags: {
        select: {
          tag: true,
        },
      },
    },
  })

  res.json(ratings)
})

app.get('/ratings/:raterId', async (req, res) => {
  const rater_id = getNumber(req.params.raterId)

  const ratings = await prisma.rating.findMany({
    where: {
      rater_id: rater_id,
    },

    include: {
      rater: true,
      sentence: {
        include: {
          source: true,
        },
      },
      tags: {
        select: {
          tag: true,
        },
      },
    },
  })

  res.json(ratings)
})

export default {
  path: '/api/stats',
  handler: app,
}
