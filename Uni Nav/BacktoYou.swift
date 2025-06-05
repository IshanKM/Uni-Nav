// LostAndFoundView.swift
import SwiftUI

struct LostAndFoundView: View {
    @State private var showLostItemForm = false
    @State private var showFoundItemForm = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Main Content
            VStack(spacing: 0) {
                // Title
                Text("Lost your Item ?")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.top, 60)
                    .padding(.bottom, 40)
                
                // Illustration Section
                ZStack {
                    // Orange arrows
                    HStack {
                        // Left arrow
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.orange)
                            .font(.system(size: 24, weight: .medium))
                            .rotationEffect(.degrees(-30))
                            .offset(x: -40, y: -30)
                        
                        Spacer()
                        
                        // Right arrow
                        Image(systemName: "arrow.up.left")
                            .foregroundColor(.orange)
                            .font(.system(size: 24, weight: .medium))
                            .rotationEffect(.degrees(30))
                            .offset(x: 40, y: -30)
                    }
                    .frame(width: 200)
                    
                    // Question mark
                    Text("?")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.teal)
                        .offset(y: -50)
                    
                    // Person illustration
                    VStack(spacing: 0) {
                        // Head with hand
                        ZStack {
                            // Main head
                            Ellipse()
                                .fill(Color(red: 0.1, green: 0.2, blue: 0.6))
                                .frame(width: 50, height: 55)
                            
                            // Hand on head
                            Ellipse()
                                .fill(Color(red: 0.1, green: 0.2, blue: 0.6))
                                .frame(width: 20, height: 25)
                                .offset(x: 25, y: -5)
                        }
                        
                        // Neck
                        Rectangle()
                            .fill(Color(red: 0.1, green: 0.2, blue: 0.6))
                            .frame(width: 15, height: 10)
                        
                        // Body/Torso
                        ZStack {
                            // Main body
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 0.1, green: 0.2, blue: 0.6))
                                .frame(width: 90, height: 110)
                            
                            // Right arm (visible arm)
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(red: 0.1, green: 0.2, blue: 0.6))
                                .frame(width: 25, height: 70)
                                .offset(x: 35, y: -20)
                                .rotationEffect(.degrees(-20))
                        }
                    }
                    .offset(y: 20)
                }
                .frame(height: 180)
                .padding(.bottom, 50)
                
                // Description Text
                VStack(spacing: 4) {
                    Text("Report or Announce lost items on the")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Text("campus.")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Text("Submit, view, and get notified—fast")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                    Text("and easy!")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                }
                .multilineTextAlignment(.center)
                .padding(.bottom, 50)
                
                // Action Buttons
                VStack(spacing: 16) {
                    // I Lost Something Button
                    Button(action: {
                        showLostItemForm = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.blue)
                                .font(.system(size: 18, weight: .medium))
                            
                            Text("I Lost Something")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color.black, lineWidth: 1.5)
                        )
                        .cornerRadius(25)
                    }
                    
                    // Announce Found Item Button
                    Button(action: {
                        showFoundItemForm = true
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                            
                            Text("Announce Found Item")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 16)
                        .background(Color.green)
                        .cornerRadius(25)
                    }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
            .background(Color.white)
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showLostItemForm) {
            LostItemFormView()
        }
        .sheet(isPresented: $showFoundItemForm) {
            FoundItemFormView()
        }
    }
}

// Lost Item Form View
struct LostItemFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var itemName = ""
    @State private var itemDescription = ""
    @State private var lastSeenLocation = ""
    @State private var contactInfo = ""
    @State private var selectedCategory = "Electronics"
    
    let categories = ["Electronics", "Clothing", "Books", "Accessories", "Documents", "Other"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Report Lost Item")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text("Fill in the details to help others find your item")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        // Item Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Item Name")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("e.g., iPhone 13, Blue Backpack", text: $itemName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Category
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Category")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Describe your item in detail...", text: $itemDescription, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                        // Last Seen Location
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Last Seen Location")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("e.g., Library, Cafeteria, Lecture Hall 01", text: $lastSeenLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Contact Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contact Information")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Your phone number or email", text: $contactInfo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Submit Button
                    Button(action: {
                        // Handle form submission
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Submit Report")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

// Found Item Form View
struct FoundItemFormView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var itemName = ""
    @State private var itemDescription = ""
    @State private var foundLocation = ""
    @State private var contactInfo = ""
    @State private var selectedCategory = "Electronics"
    
    let categories = ["Electronics", "Clothing", "Books", "Accessories", "Documents", "Other"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("Announce Found Item")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Text("Help someone find their lost item")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Form Fields
                    VStack(spacing: 20) {
                        // Item Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Item Found")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("e.g., iPhone 13, Blue Backpack", text: $itemName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Category
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Category")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(categories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                        }
                        
                        // Description
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Describe the item you found...", text: $itemDescription, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                        // Found Location
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Found Location")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Where did you find this item?", text: $foundLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        // Contact Info
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contact Information")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Your phone number or email", text: $contactInfo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Submit Button
                    Button(action: {
                        // Handle form submission
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Announce Found Item")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Spacer(minLength: 40)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}

// Preview
struct LostAndFoundView_Previews: PreviewProvider {
    static var previews: some View {
        LostAndFoundView()
    }
}
