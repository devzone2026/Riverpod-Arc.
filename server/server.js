// Minimal broadcast chat server.
// Protocol (JSON text frames):
//   client -> server: { type: "message", id, senderId, sender, text }
//   server -> all:    { type: "message", id, senderId, sender, text, ts }
//   server -> all:    { type: "presence", online: <number> }
const { WebSocketServer, WebSocket } = require('ws');

const PORT = Number(process.env.PORT) || 8080;
const wss = new WebSocketServer({ port: PORT });

function broadcast(payload) {
  const data = JSON.stringify(payload);
  for (const client of wss.clients) {
    if (client.readyState === WebSocket.OPEN) client.send(data);
  }
}

const broadcastPresence = () =>
  broadcast({ type: 'presence', online: wss.clients.size });

wss.on('connection', (ws) => {
  ws.isAlive = true;
  ws.on('pong', () => { ws.isAlive = true; });

  broadcastPresence();

  ws.on('message', (raw) => {
    let msg;
    try { msg = JSON.parse(raw.toString()); } catch { return; }
    if (!msg || msg.type !== 'message' || typeof msg.text !== 'string') return;

    const text = msg.text.trim().slice(0, 1000);
    if (!text) return;

    broadcast({
      type: 'message',
      id: String(msg.id ?? Date.now()),
      senderId: String(msg.senderId ?? ''),
      sender: String(msg.sender ?? 'Anonymous').slice(0, 32),
      text,
      ts: new Date().toISOString(),
    });
  });

  ws.on('close', broadcastPresence);
  ws.on('error', () => {});
});

// Drop dead connections (phones that lost network without closing).
setInterval(() => {
  for (const ws of wss.clients) {
    if (!ws.isAlive) { ws.terminate(); continue; }
    ws.isAlive = false;
    ws.ping();
  }
}, 30000);

console.log(`Chat server listening on ws://0.0.0.0:${PORT}`);
