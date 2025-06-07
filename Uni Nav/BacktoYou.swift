// LostAndFoundView.swift
import SwiftUI

struct BacktoYouView: View {
    @State private var showLostItemForm = false
    @State private var showFoundItemForm = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            VStack(spacing: 0) {
                
                Text("Lost your Item ?")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.top, 60)
                    .padding(.bottom, 40)
                
                
                ZStack {
                    
                    HStack {
                       
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(.orange)
                            .font(.system(size: 24, weight: .medium))
                            .rotationEffect(.degrees(-30))
                            .offset(x: -40, y: -30)
                        
                        Spacer()
                        
                    
                        Image(systemName: "arrow.up.left")
                            .foregroundColor(.orange)
                            .font(.system(size: 24, weight: .medium))
                            .rotationEffect(.degrees(30))
                            .offset(x: 40, y: -30)
                    }
                    .frame(width: 200)
                    
                   
                    Text("?")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(.teal)
                        .offset(y: -50)
                    
                    VStack(spacing: 0) {
                        
                        ZStack {
                           
                            Ellipse()
                                .fill(Color(red: 0.1, green: 0.2, blue: 0.6))
                                .frame(width: 50, height: 55)
                            
                            
                            Ellipse()
                                .fill(Color(red: 0.1, green: 0.2, blue: 0.6))
                                .frame(width: 20, height: 25)
                                .offset(x: 25, y: -5)
                        }
                        
                       
                        Rectangle()
                            .fill(Color(red: 0.1, green: 0.2, blue: 0.6))
                            .frame(width: 15, height: 10)
                        
                       
                        ZStack {
                           
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color(red: 0.1, green: 0.2, blue: 0.6))
                                .frame(width: 90, height: 110)
                            
                           
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
                
               
                VStack(spacing: 16) {
                   
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
                    
                   
                    VStack(spacing: 20) {
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Item Name")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("e.g., iPhone 13, Blue Backpack", text: $itemName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                        
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
                        
                     
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Describe your item in detail...", text: $itemDescription, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                      
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Last Seen Location")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("e.g., Library, Cafeteria, Lecture Hall 01", text: $lastSeenLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                      
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contact Information")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Your phone number or email", text: $contactInfo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    
                    Button(action: {
                        
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
                    
                    
                    VStack(spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Item Found")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("e.g., iPhone 13, Blue Backpack", text: $itemName)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                        
                       
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
                        
                      
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Description")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Describe the item you found...", text: $itemDescription, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .lineLimit(3...6)
                        }
                        
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Found Location")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Where did you find this item?", text: $foundLocation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                       
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Contact Information")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            TextField("Your phone number or email", text: $contactInfo)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }
                    .padding(.horizontal, 20)
                    
                   
                    Button(action: {
                       
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


struct LostAndFoundView_Previews: PreviewProvider {
    static var previews: some View {
        BacktoYouView()
    }
}
