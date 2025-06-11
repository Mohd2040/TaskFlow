// ✅ تحميل المتغيرات البيئية
require("dotenv").config();

// ✅ استيراد المكتبات
const express = require("express");
const mongoose = require("mongoose");
const app = express();

// ✅ الإعدادات العامة
const PORT = process.env.PORT || 5000;
const MONGO_URI = process.env.MONGO_URI;

if (!MONGO_URI) {
  console.error("❌ Error: MONGO_URI not defined in .env");
  process.exit(1); // الخروج من التطبيق
}

// ✅ إعداد الوسطاء (Middlewares)
app.use(express.static("public"));
app.use(express.json());

// ✅ إعداد المسارات
const taskRoutes = require("./routes/tasks");
const authRoutes = require("./routes/auth");

app.use("/api/tasks", taskRoutes);
app.use("/api/auth", authRoutes);

// ✅ الاتصال بقاعدة البيانات ثم تشغيل السيرفر
mongoose
  .connect(MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  })
  .then(() => {
    console.log("✅ Connected to MongoDB Atlas");

    app.listen(PORT, () => {
      console.log(`🚀 Server is running on http://localhost:${PORT}`);
    });
  })
  .catch((err) => {
    console.error("❌ MongoDB connection failed:", err.message);
    process.exit(1);
  });
