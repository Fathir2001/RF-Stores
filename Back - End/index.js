require("dotenv").config();
const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const authRoutes = require('./routes/Auth');
const pantryRoutes = require('./routes/pantry');
const vegetablesRoutes = require('./routes/vegetable');
const dairyRoutes = require('./routes/dairy');
const cartRoutes = require('./routes/cart');

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Enhanced MongoDB connection
const connectDB = async () => {
  try {
    const conn = await mongoose.connect(process.env.MONGODB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log(`MongoDB Connected: ${conn.connection.host}`);
  } catch (error) {
    console.error("MongoDB connection failed:", error.message);
    process.exit(1);
  }
};

// Connect to MongoDB
connectDB();

// Test route
app.get("/", (req, res) => {
  res.json({ message: "RF-Stores API is running" });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: "Something went wrong!" });
});

const PORT = process.env.PORT || 5000;

const server = app.listen(PORT, () => {
  console.log(`Server running in ${process.env.NODE_ENV} mode on port ${PORT}`);
});

// Handle unhandled promise rejections
process.on("unhandledRejection", (err) => {
  console.error("Unhandled Rejection:", err);
  server.close(() => process.exit(1));
});

app.use('/api/auth', authRoutes);
app.use('/api/pantry', pantryRoutes);
app.use('/api/vegetables', vegetablesRoutes);
app.use('/api/dairy', dairyRoutes);
app.use('/api/cart', cartRoutes);
