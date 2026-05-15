#!/bin/bash
# Arc Network Transaction Monitor - Setup Script

echo "================================================"
echo "  Arc Network Transaction Monitor - Setup"
echo "================================================"
echo ""

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 not found. Please install Python 3.9+"
    exit 1
fi
echo "✅ Python $(python3 --version)"

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found. Please install Node.js 18+"
    exit 1
fi
echo "✅ Node.js $(node --version)"
echo ""

# Setup Backend
echo "📦 Setting up Backend..."
cd backend
python3 -m venv venv
source venv/bin/activate || source venv/Scripts/activate   # Windows compat
pip install -r requirements.txt -q
cp .env.example .env
echo "✅ Backend dependencies installed"
echo ""

# Setup Frontend
echo "📦 Setting up Frontend..."
cd ../frontend
npm install --silent
echo "✅ Frontend dependencies installed"
echo ""

echo "================================================"
echo "  Setup Complete! 🎉"
echo "================================================"
echo ""
echo "To start the app, run TWO terminals:"
echo ""
echo "  Terminal 1 (Backend):"
echo "    cd backend"
echo "    source venv/bin/activate   # Linux/Mac"
echo "    # venv\\Scripts\\activate   # Windows"
echo "    python main.py"
echo ""
echo "  Terminal 2 (Frontend):"
echo "    cd frontend"
echo "    npm run dev"
echo ""
echo "  Then open: http://localhost:5173"
echo ""
echo "  API Docs: http://localhost:8000/docs"
echo "================================================"
