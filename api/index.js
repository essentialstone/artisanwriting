import express from 'express'
import bodyParser from 'body-parser'
import { PrismaClient } from '@prisma/client'

const prisma = new PrismaClient()
const app = express()
const pageSize = 3

app.use(express.json())
app.use(bodyParser.json())

app.get('/tags', async (req, res) => {
  const tags = await prisma.tag.findMany()
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

app.get('/raters/:raterId/sentences', async (req, res) => {
  const { raterId } = req.params
  const id = parseInt(raterId)
  const sentences = await prisma.$queryRaw`
    SELECT *
    FROM "Sentence" AS s
    WHERE 
      "deleted" = false 
    AND
      s.id NOT IN (
        SELECT "sentenceId" 
        FROM "Rating" 
        WHERE 
          "raterId" != ${id}
      ) 
    ORDER BY random() 
    LIMIT ${pageSize}
  `
  res.json(sentences)
})

app.post('/raters/:raterId/ratings', async (req, res) => {
  const raterId = parseInt(req.params.raterId)
  const ratings = req.body.map((it) => ({ ...it, raterId }))

  await prisma.rating.createMany({
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
