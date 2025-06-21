// routes/auth.js
const express = require("express");
const router = express.Router();
const User = require("../models/User");
const Task = require("../models/Task");
const jwt = require("jsonwebtoken");
const protect = require("../middleware/authMiddleware");


// ✅ تسجيل مستخدم جديد 
router.post("/register", async (req, res) => {
  try {
    const { username, email, password } = req.body; // ✅ فقط المطلوب

    // تحقق من وجود المستخدم مسبقًا
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ error: "Email already in use" });
    }

    // إنشاء مستخدم جديد
    const user = new User({ username, email, password });
    await user.save();

    res.status(201).json({ message: "Registered successfully!" });
  } catch (err) {
    console.error("Registration error:", err.message);
    res.status(500).json({ error: "Registration failed" });
  }
});

// ✅ تسجيل الدخول واسترجاع بيانات المستخدم والمهام
router.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    // العثور على المستخدم
    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ error: "Invalid credentials" });

    const isMatch = await user.matchPassword(password);
    if (!isMatch) return res.status(400).json({ error: "Invalid credentials" });

    // إنشاء التوكن
    const token = jwt.sign({ userId: user._id }, process.env.JWT_SECRET, {
      expiresIn: "1d",
    });

    // ✅ جلب المهام الخاصة بالمستخدم
    const tasks = await Task.find({ user: user._id }).sort({ createdAt: -1 });

    res.json({
      token,
      user: {
        id: user._id,
        username: user.username,
        email: user.email,
      },
      tasks,
    });
  } catch (err) {
    console.error("Login error:", err.message);
    res.status(500).json({ error: "Login failed" });
  }
});

// ✅ جلب بيانات المستخدم الحالي (protected route)
router.get("/me", protect, async (req, res) => {
  try {
    // req.user.id بيجي من الـ middleware بتاع protect بعد التحقق من التوكن
    const user = await User.findById(req.user.id).select("username email");
    if (!user) {
        return res.status(404).json({ message: "User not found" });
    }
    // 🚀 هنا الحل: رجع بيانات المستخدم كـ JSON response
    res.json(user);
  } catch (err) {
    console.error("Error in /me route:", err.message); // اطبع الخطأ عشان تشوفه
    res.status(500).json({ message: "Server error" });
  }
});

module.exports = router;
