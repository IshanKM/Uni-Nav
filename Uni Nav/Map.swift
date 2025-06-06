// CampusMapView.swift - Fixed Zoom and Pan like Google Maps
import SwiftUI
import WebKit

struct CampusMapView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedFloor = 0
    @State private var searchText = ""
    @State private var selectedRoom: RoomInfo?
    @State private var showRoomDetails = false
    @State private var scale: CGFloat = 1.0
    @State private var offset = CGSize.zero
    
    let floors = ["G", "1", "2"]
    
    // Updated room database with better coordinates and search terms
    let roomDatabase: [String: RoomInfo] = [
        "Cafateria": RoomInfo(
            id: "Cafateria",
            name: "Cafeteria",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.6, y: 0.1),
            searchTerms: ["cafeteria", "cafe", "food", "dining"]
        ),
        "LectureHall01": RoomInfo(
            id: "LectureHall01",
            name: "Lecture Hall 01",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.5, y: 0.3),
            searchTerms: ["lecture hall 01", "lecture hall 1", "hall 01", "hall 1", "lh01", "lh1"]
        ),
        "LectureHall02": RoomInfo(
            id: "LectureHall02",
            name: "Lecture Hall 02",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.75, y: 0.3),
            searchTerms: ["lecture hall 02", "lecture hall 2", "hall 02", "hall 2", "lh02", "lh2"]
        ),
        "LectureHall03": RoomInfo(
            id: "LectureHall03",
            name: "Lecture Hall 03",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.75, y: 0.4),
            searchTerms: ["lecture hall 03", "lecture hall 3", "hall 03", "hall 3", "lh03", "lh3"]
        ),
        "LectureHall04": RoomInfo(
            id: "LectureHall04",
            name: "Lecture Hall 04",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.8, y: 0.65),
            searchTerms: ["lecture hall 04", "lecture hall 4", "hall 04", "hall 4", "lh04", "lh4"]
        ),
        "Elavator02": RoomInfo(
            id: "Elavator02",
            name: "Elevator 02",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.78, y: 0.15),
            searchTerms: ["elevator 02", "elevator 2", "lift 02", "lift 2"]
        ),
        "Elevator01": RoomInfo(
            id: "Elevator01",
            name: "Elevator 01",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.5, y: 0.65),
            searchTerms: ["elevator 01", "elevator 1", "lift 01", "lift 1"]
        ),
        "Reception_ground": RoomInfo(
            id: "Reception_ground",
            name: "Reception",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.2, y: 0.45),
            searchTerms: ["reception", "front desk", "lobby"]
        ),
        "Book_Shop_ground": RoomInfo(
            id: "Book_Shop_ground",
            name: "Book Shop",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.72, y: 0.85),
            searchTerms: ["book shop", "bookstore", "books"]
        ),
        "carrier_guide": RoomInfo(
            id: "carrier_guide",
            name: "Career Guide Unit",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.49, y: 0.76),
            searchTerms: ["career guide", "career", "guidance", "counseling"]
        ),
        "Entrance01": RoomInfo(
            id: "Entrance01",
            name: "Entrance 1",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.63, y: 0.95),
            searchTerms: ["entrance 1", "entrance 01", "entry 1"]
        ),
        "Entrance2_ground": RoomInfo(
            id: "Entrance2_ground",
            name: "Entrance 2",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.05, y: 0.6),
            searchTerms: ["entrance 2", "entrance 02", "entry 2"]
        ),
        "Entrance_gate": RoomInfo(
            id: "Entrance_gate",
            name: "Main Entrance",
            floor: 0,
            displayFloor: "Ground Floor",
            position: CGPoint(x: 0.07, y: 0.98),
            searchTerms: ["main entrance", "main gate", "entrance gate"]
        )
    ]
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    
                    Spacer()
                    
                    Text("Campus Map")
                        .font(.headline)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Button(action: {
                        // Reset zoom and position
                        withAnimation(.easeInOut(duration: 0.5)) {
                            scale = 1.0
                            offset = .zero
                        }
                    }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 15)
                .background(Color.white)
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search rooms...", text: $searchText)
                        .font(.subheadline)
                        .onSubmit {
                            searchForRoom()
                        }
                    
                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                            selectedRoom = nil
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                .background(Color.white)
                
                // Interactive SVG Map
                ZStack {
                    GeometryReader { geometry in
                        ZStack {
                            // Enhanced SVG WebView with click detection
                            EnhancedSVGWebView(
                                svgFileName: "Ground-flow",
                                selectedRoom: $selectedRoom,
                                roomDatabase: roomDatabase
                            )
                            .scaleEffect(scale)
                            .offset(offset)
                            .gesture(
                                SimultaneousGesture(
                                    // Pinch to zoom gesture
                                    MagnificationGesture()
                                        .onChanged { value in
                                            let newScale = scale * value
                                            scale = min(max(newScale, 0.5), 3.0)
                                        },
                                    
                                    // Drag to pan gesture
                                    DragGesture()
                                        .onChanged { value in
                                            offset = value.translation
                                        }
                                        .onEnded { value in
                                            // Keep the final offset
                                            offset = value.translation
                                        }
                                )
                            )
                            
                            // Selected room marker with animation
                            if let selectedRoom = selectedRoom {
                                VStack {
                                    // Pulsing outer circle
                                    Circle()
                                        .fill(Color.red.opacity(0.3))
                                        .frame(width: 40, height: 40)
                                        .scaleEffect(1.5)
                                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: selectedRoom)
                                    
                                    // Inner marker
                                    Circle()
                                        .fill(Color.red)
                                        .frame(width: 20, height: 20)
                                        .overlay(
                                            Circle()
                                                .stroke(Color.white, lineWidth: 3)
                                        )
                                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                                }
                                .position(
                                    x: (selectedRoom.position.x * geometry.size.width * scale) + offset.width + geometry.size.width/2,
                                    y: (selectedRoom.position.y * geometry.size.height * scale) + offset.height + geometry.size.height/2
                                )
                                .animation(.spring(response: 0.5, dampingFraction: 0.8), value: selectedRoom)
                            }
                        }
                    }
                    
                    // Floor Selector
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            HStack(spacing: 8) {
                                ForEach(0..<floors.count, id: \.self) { index in
                                    Button(action: {
                                        selectedFloor = index
                                        selectedRoom = nil
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            scale = 1.0
                                            offset = .zero
                                        }
                                    }) {
                                        Text(floors[index])
                                            .font(.headline)
                                            .fontWeight(.medium)
                                            .foregroundColor(selectedFloor == index ? .white : .gray)
                                            .frame(width: 44, height: 44)
                                            .background(selectedFloor == index ? Color.blue : Color.white)
                                            .cornerRadius(22)
                                            .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, selectedRoom != nil ? 200 : 100)
                    }
                    
                    // Zoom controls - Fixed positioning and functionality
                    VStack {
                        HStack {
                            Spacer()
                            
                            VStack(spacing: 8) {
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        let newScale = scale * 1.3
                                        scale = min(newScale, 3.0)
                                    }
                                }) {
                                    Image(systemName: "plus")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .frame(width: 44, height: 44)
                                        .background(Color.white)
                                        .cornerRadius(22)
                                        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
                                }
                                
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        let newScale = scale / 1.3
                                        scale = max(newScale, 0.5)
                                    }
                                }) {
                                    Image(systemName: "minus")
                                        .font(.title2)
                                        .fontWeight(.medium)
                                        .foregroundColor(.black)
                                        .frame(width: 44, height: 44)
                                        .background(Color.white)
                                        .cornerRadius(22)
                                        .shadow(color: .gray.opacity(0.3), radius: 3, x: 0, y: 2)
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                }
            }
            
            // Enhanced Room Details Popup
            if let room = selectedRoom {
                VStack {
                    Spacer()
                    
                    EnhancedRoomDetailsPopup(
                        room: room,
                        onDetailsClick: {
                            showRoomDetails = true
                        },
                        onDirectionsClick: {
                            // Add directions functionality here
                            print("Directions to \(room.name)")
                        },
                        onClose: {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                                selectedRoom = nil
                            }
                        }
                    )
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .animation(.spring(response: 0.5, dampingFraction: 0.8), value: selectedRoom)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showRoomDetails) {
            if let room = selectedRoom {
                RoomDetailView(room: room)
            }
        }
    }
    
    private func searchForRoom() {
        let searchQuery = searchText.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !searchQuery.isEmpty else { return }
        
        // Search through all rooms and their search terms
        for (_, room) in roomDatabase {
            if room.searchTerms.contains(where: { $0.contains(searchQuery) }) ||
               room.name.lowercased().contains(searchQuery) {
                
                selectedFloor = room.floor
                
                // Animate to the room location
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.spring(response: 0.8, dampingFraction: 0.8)) {
                        selectedRoom = room
                        
                        // Auto-zoom to the room
                        scale = 2.0
                        
                        // Center the room (adjust offset to center the selected room)
                        offset = CGSize(width: -100, height: -100)
                    }
                }
                break
            }
        }
    }
}

// Simplified SVG WebView without gesture conflicts
struct EnhancedSVGWebView: UIViewRepresentable {
    let svgFileName: String
    @Binding var selectedRoom: RoomInfo?
    let roomDatabase: [String: RoomInfo]
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.navigationDelegate = context.coordinator
        
        // Disable built-in gestures to prevent conflicts
        webView.scrollView.pinchGestureRecognizer?.isEnabled = false
        webView.scrollView.panGestureRecognizer.isEnabled = false
        
        loadSVG(in: webView, context: context)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        context.coordinator.parent = self
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    private func loadSVG(in webView: WKWebView, context: Context) {
        if let svgPath = Bundle.main.path(forResource: svgFileName, ofType: "svg"),
           let svgContent = try? String(contentsOfFile: svgPath) {
            
            // Create room click handlers JavaScript
            let roomClickHandlers = roomDatabase.keys.map { roomId in
                """
                document.getElementById('\(roomId)')?.addEventListener('click', function(e) {
                    e.preventDefault();
                    e.stopPropagation();
                    window.webkit.messageHandlers.roomClicked.postMessage('\(roomId)');
                });
                """
            }.joined(separator: "\n")
            
            let html = """
            <!DOCTYPE html>
            <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
                <style>
                    body { 
                        margin: 0; 
                        padding: 0; 
                        background: transparent;
                        overflow: hidden;
                        user-select: none;
                        -webkit-user-select: none;
                        -webkit-touch-callout: none;
                    }
                    svg { 
                        width: 100vw; 
                        height: 100vh; 
                        display: block;
                        pointer-events: auto;
                    }
                    /* Make room elements clickable */
                    svg [id] {
                        cursor: pointer;
                        transition: all 0.2s ease;
                        pointer-events: auto;
                    }
                    svg [id]:hover {
                        opacity: 0.8;
                        filter: brightness(1.1);
                    }
                </style>
            </head>
            <body>
                \(svgContent)
                <script>
                    // Add click handlers for all rooms
                    \(roomClickHandlers)
                    
                    // Prevent default behaviors that might interfere
                    document.addEventListener('touchstart', function(e) {
                        // Allow single touches for clicking
                        if (e.touches.length === 1) {
                            return true;
                        }
                        e.preventDefault();
                    }, { passive: false });
                    
                    document.addEventListener('touchmove', function(e) {
                        e.preventDefault();
                    }, { passive: false });
                    
                    document.addEventListener('gesturestart', function(e) {
                        e.preventDefault();
                    });
                    
                    document.addEventListener('gesturechange', function(e) {
                        e.preventDefault();
                    });
                    
                    document.addEventListener('gestureend', function(e) {
                        e.preventDefault();
                    });
                </script>
            </body>
            </html>
            """
            
            // Add message handler for room clicks
            webView.configuration.userContentController.add(context.coordinator, name: "roomClicked")
            
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        var parent: EnhancedSVGWebView
        
        init(_ parent: EnhancedSVGWebView) {
            self.parent = parent
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "roomClicked", let roomId = message.body as? String {
                // Handle room click
                if let room = parent.roomDatabase[roomId] {
                    DispatchQueue.main.async {
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            self.parent.selectedRoom = room
                        }
                    }
                }
            }
        }
    }
}

// Enhanced Room Info Model with search terms
struct RoomInfo: Identifiable, Equatable {
    let id: String
    let name: String
    let floor: Int
    let displayFloor: String
    let position: CGPoint // Normalized coordinates (0.0 to 1.0)
    let searchTerms: [String]
    
    static func == (lhs: RoomInfo, rhs: RoomInfo) -> Bool {
        lhs.id == rhs.id
    }
}

// Enhanced Room Details Popup
struct EnhancedRoomDetailsPopup: View {
    let room: RoomInfo
    let onDetailsClick: () -> Void
    let onDirectionsClick: () -> Void
    let onClose: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            // Handle bar
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.gray.opacity(0.3))
                .frame(width: 40, height: 4)
                .padding(.top, 8)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(room.name)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        HStack {
                            Image(systemName: "building.2")
                                .foregroundColor(.gray)
                                .font(.caption)
                            Text(room.displayFloor)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: onClose) {
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .font(.title3)
                            .padding(8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(20)
                    }
                }
                
                // Action buttons
                HStack(spacing: 12) {
                    Button(action: onDirectionsClick) {
                        HStack {
                            Image(systemName: "location.circle.fill")
                            Text("Directions")
                        }
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    }
                    
                    Button(action: onDetailsClick) {
                        HStack {
                            Image(systemName: "info.circle")
                            Text("Details")
                        }
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.red)
                        .cornerRadius(8)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(Color.white)
        .cornerRadius(16, corners: [.topLeft, .topRight])
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
    }
}

// Enhanced Room Detail View
struct RoomDetailView: View {
    let room: RoomInfo
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text(room.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "building.2")
                                .foregroundColor(.gray)
                            Text(room.displayFloor)
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Divider()
                    
                    // Details
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Room Information")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        DetailRow(title: "Room ID", value: room.id, icon: "number")
                        DetailRow(title: "Floor", value: room.displayFloor, icon: "building.2")
                        DetailRow(title: "Position", value: "(\(String(format: "%.2f", room.position.x)), \(String(format: "%.2f", room.position.y)))", icon: "location")
                        
                        if !room.searchTerms.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                HStack {
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                    Text("Search Terms")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                }
                                
                                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
                                    ForEach(room.searchTerms, id: \.self) { term in
                                        Text(term)
                                            .font(.caption)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 4)
                                            .background(Color.blue.opacity(0.1))
                                            .foregroundColor(.blue)
                                            .cornerRadius(12)
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
                .padding(20)
            }
            .navigationBarItems(
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

struct DetailRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
                .font(.caption)
                .frame(width: 20)
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}

// Extension for corner radius
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// Preview
struct CampusMapView_Previews: PreviewProvider {
    static var previews: some View {
        CampusMapView()
    }
}
