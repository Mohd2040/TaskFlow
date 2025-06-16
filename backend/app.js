// ✅ تحميل المتغيرات البيئية
require("dotenv").config();
// ✅ استيراد المكتبات
const express = require("express");
const mongoose = require("mongoose");
const path = require("path"); // 👈 لإدارة المسارات
const app = express();
// ✅ الإعدادات العامة
const PORT = process.env.PORT || 5000;
const MONGODB_URL = process.env.MONGODB_URL;
const authMiddleware = require("./middleware/auth");

if (!MONGODB_URL) {
  console.error("❌ Error: MONGODB_URL not defined in .env");
  process.exit(1); // الخروج من التطبيق
}
// ✅ إعداد الوسطاء (Middlewares)
app.use(express.json());

// ✅ تقديم ملفات الواجهة الأمامية من مجلد "public"
app.use(express.static(path.join(__dirname, "./public")));
app.use(express.static('public'));
// ✅ إعداد المسارات الخاصة بالـ API
const authRoutes = require("./routes/auth");
const taskRoutes = require("./routes/tasks");

app.use("/api/users", authRoutes); // 👈 مفتوح بدون توكن
app.use("/api/tasks", authMiddleware, taskRoutes); // محمي بالتوكن

// ✅ المسارات للصفحات الرئيسية
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "./public/index.html"));
});

app.get("/login", (req, res) => {
  res.sendFile(path.join(__dirname, "./public/login.html"));
});

app.get("/register", (req, res) => {
  res.sendFile(path.join(__dirname, "./public/register.html"));
});

app.get("/tasks", (req, res) => {
  res.sendFile(path.join(__dirname, "./public/tasks.html"));
});

// ✅ التعامل مع أي رابط غير معروف (يُرسل إلى الصفحة الرئيسية)
app.get("*", (req, res) => {
  res.sendFile(path.join(__dirname, "./public/index.html"));
});

// ✅ الاتصال بقاعدة البيانات ثم تشغيل السيرفر
mongoose
  .connect(MONGODB_URL, {
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
