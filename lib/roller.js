import { N, C, F, Streams } from '@masala/parser'

const NDie = C.charIn('dD').drop().then(N.integer())
const Roll = N.integer()
  .opt()
  .then(NDie)
  .map((tup) => {
    const count = tup.at(0).orElse(1)
    const sides = tup.at(1)

    return initList(count, sides).map(rollD)
  })

export function parseRoll(input) {
  return Roll.parse(Streams.ofString(input))
}

function initList(count, value) {
  const list = []

  for (let i = 0; i < count; i++) {
    list.push(value)
  }

  return list
}

function rollD(n) {
  return {
    d: n,
    value: Math.floor(Math.random() * n) + 1,
  }
}
