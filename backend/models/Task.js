// backend/models/Task.js

const mongoose = require("mongoose");

const TaskSchema = new mongoose.Schema({
  title: {
    type: String,
    required: true,
    trim: true,
  },
  description: {
    type: String,
  },
  // ✅ إضافة حقل 'type'
  type: {
    type: String,
    enum: ["Frontend", "Backend", "DevOps"], // نفس القيم اللي في الـ frontend
    default: "Frontend", // ممكن تختار قيمة افتراضية
  },
  // ✅ تعديل قيم الـ 'enum' لـ 'status' لتطابق قيم الـ frontend
  status: {
    type: String,
    enum: ["Not Started", "In Progress", "Completed"], // نستخدم نفس القيم النصية من الـ frontend
    default: "Not Started", // نعدل القيمة الافتراضية أيضاً
  },
  priority: {
    type: String,
    enum: ["Low", "Medium", "High"], // يفضل توحيدها مع الـ frontend أيضاً
    default: "Medium",
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  user: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true, // يفضل جعلها مطلوبة بما أن المهام مرتبطة بمستخدمين
  }
});

module.exports = mongoose.model("Task", TaskSchema);