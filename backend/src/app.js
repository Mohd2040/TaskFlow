const express = require("express");
const dotenv = require("dotenv");

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(express.json());

// Test route
app.get("/api/health", (req, res) => {
  res.json({ status: "OK", message: "TaskFlow API is running 🚀" });
});

app.listen(PORT, () => {
  console.log(`✅ Server running on http://localhost:${PORT}`);
});
