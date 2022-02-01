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

function getTagRatings(ratingId, tagIds) {
  return tagIds.map((it) => ({
    rating_id: ratingId,
    tag_id: it,
  }))
}

app.get('/tags', async (req, res) => {
  const tags = await prisma.tag.findMany({
    where: {
      hidden: false,
    },
  })
  res.json(tags)
})

app.get('/raters', async (req, res) => {
  const raters = await prisma.rater.findMany()
  res.json(raters)
})

app.get('/sources', async (req, res) => {
  const sources = await prisma.source.findMany()
  res.json(sources)
})

app.get('/sentences', async (req, res) => {
  const defaultPageSize = 3
  const count = getNumber(req.params.count) || defaultPageSize

  const sentences = await prisma.$queryRaw`
    SELECT
      stc.id id,
      stc.words words,
      src.id source_id,
      src.name source_name
    FROM sentence stc
    JOIN source src 
    ON 
      stc.deleted = false
    AND
      stc.source_id = src.id
    ORDER BY random() 
    LIMIT ${count};
  `
  res.json(sentences)
})

app.post('/raters/:raterId/ratings', async (req, res) => {
  const rater_id = getNumber(req.params.raterId)

  const ratings = req.body.map((rating) => ({
    rater_id: rater_id,
    sentence_id: rating.sentence_id,
    explanation: rating.explanation,
    tags: {
      create: rating.tags.map((tag_id) => ({
        tag: {
          connect: {
            id: tag_id,
          },
        },
      })),
    },
  }))

  for (let rating of ratings) {
    await prisma.rating.create({
      data: rating,
    })
  }

  res.end()
})

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

/**
 * logic for our api will go here
 */
export default {
  path: '/api',
  handler: app,
}
