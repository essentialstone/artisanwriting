export default function (socket, io) {
  return Object.freeze({
    roll(msg) {
      io.of('/gameroom').emit('roll', msg)
    },
  })
}
