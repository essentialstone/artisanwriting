import express from 'express'
import bodyParser from 'body-parser'
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()
const app = express()
const pageSize = 3

app.use(express.json())
app.use(bodyParser.json())

app.get('/tags', async (req, res) => {
  const tags = await prisma.tags.findMany()
  res.json(tags)
})

app.get('/raters', async (req, res) => {
  const raters = await prisma.raters.findMany()
  res.json(raters)
})

app.get('/sources', async (req, res) => {
  const sources = await prisma.sources.findMany()
  res.json(sources)
})
app.get('/raters/:raterId/total', async (req, res) => {
  const raterId = parseInt(req.params.raterId)

  const ratingsCount = await prisma.ratings.count({
    where: {
      rater_id: raterId,
    },
  })

  res.json(ratingsCount)
})

app.get('/raters/:raterId/sentences', async (req, res) => {
  const raterId = parseInt(req.params.raterId)
  const sentences = await prisma.$queryRaw`
    SELECT *
    FROM "sentences" AS s
    WHERE 
      "deleted" = false 
    AND
      s.id NOT IN (
        SELECT "sentence_id" 
        FROM "ratings" 
        WHERE 
          "rater_id" != ${raterId}
      ) 
    ORDER BY random() 
    LIMIT ${pageSize}
  `
  res.json(sentences)
})

app.post('/raters/:raterId/ratings', async (req, res) => {
  const rater_id = parseInt(req.params.raterId)
  const ratings = req.body.map((it) => ({ ...it, rater_id }))

  await prisma.ratings.createMany({
    skipDuplicates: true,
    data: ratings,
  })

  res.end()
})

/**
 * logic for our api will go here
 */
export default {
  path: '/api',
  handler: app,
}
