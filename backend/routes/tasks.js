// backend/routes/tasks.js
const express = require("express");
const router = express.Router();
const Task = require("../models/Task");
const protect = require("../middleware/authMiddleware");

// ✅ Get all tasks for the logged-in user
router.get("/", protect, async (req, res) => {
  try {
    const tasks = await Task.find({ user: req.user._id }).sort({ createdAt: -1 });
    res.json(tasks);
  } catch (err) {
    console.error("Error getting tasks:", err.message);
    res.status(500).json({ error: "Server error" });
  }
});

// ✅ Create a new task for the logged-in user
router.post("/", protect, async (req, res) => {
  try {
    const { title, description, type, priority, status } = req.body;

    // ✅ التحقق من الحقول المطلوبة (مهم جدًا)
    if (!title || !type || !priority || !status) {
      return res.status(400).json({ error: "الرجاء إدخال جميع الحقول المطلوبة (العنوان، النوع، الأولوية، الحالة)." });
    }

    const task = new Task({
      user: req.user._id,
      title,
      description,
      type,       // سيتم إضافته الآن للـ Model
      priority,
      status // سيتم التحقق من قيمته بواسطة Mongoose بناءً على الـ enum في الـ Model
      // لا نحتاج لـ || "not_started" هنا بما أن الـ frontend يرسل قيمة
      // وإذا أردت قيمة افتراضية ستُأخذ من الـ Model نفسه لو لم ترسل
    });

    const saved = await task.save();
    res.status(201).json(saved);
  } catch (err) {
    console.error("Error creating task:", err.message);
    // ✅ طباعة رسالة الخطأ من Mongoose لتحديد المشكلة بدقة
    // Mongoose Validation Errors عادةً ما تكون في err.errors
    let errorMessage = err.message;
    if (err.name === 'ValidationError') {
        const errors = Object.values(err.errors).map(el => el.message);
        errorMessage = errors.join(', ');
    }
    res.status(400).json({ error: errorMessage });
  }
});

// ✅ Get a single task by ID (if owned by user)
router.get("/:id", protect, async (req, res) => {
  try {
    const task = await Task.findOne({ _id: req.params.id, user: req.user._id });
    if (!task) return res.status(404).json({ error: "Task not found" });
    res.json(task);
  } catch (err) {
    console.error("Error getting single task:", err.message);
    res.status(400).json({ error: "Invalid ID or Server error" });
  }
});

// ✅ Update task by ID (if owned by user)
router.put("/:id", protect, async (req, res) => {
  try {
    const updated = await Task.findOneAndUpdate(
      { _id: req.params.id, user: req.user._id },
      req.body,
      { new: true, runValidators: true } // ✅ إضافة runValidators للتأكد من التحقق عند التحديث
    );
    if (!updated) return res.status(404).json({ error: "Task not found" });
    res.json(updated);
  } catch (err) {
    console.error("Error updating task:", err.message);
    let errorMessage = err.message;
    if (err.name === 'ValidationError') {
        const errors = Object.values(err.errors).map(el => el.message);
        errorMessage = errors.join(', ');
    }
    res.status(400).json({ error: "Invalid data: " + errorMessage });
  }
});

// ✅ Delete task by ID (if owned by user)
router.delete("/:id", protect, async (req, res) => {
  try {
    const deleted = await Task.findOneAndDelete({ _id: req.params.id, user: req.user._id });
    if (!deleted) return res.status(404).json({ error: "Task not found" });
    res.json({ message: "Task deleted successfully" });
  } catch (err) {
    console.error("Error deleting task:", err.message);
    res.status(400).json({ error: "Invalid ID or Server error" });
  }
});

module.exports = router;