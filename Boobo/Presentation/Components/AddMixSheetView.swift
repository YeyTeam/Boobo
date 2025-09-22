//
//  AddMixSheetView.swift
//  Boobo
//
//  Created by Abdul Jabbar on 18/09/25.
//

import SwiftUI
import SwiftData

struct AddMixSheetView: View {
    @Binding var name: String
    var data:[SoundModelBeta]
    var onSave: (String) -> Void

    // SwiftData context + your manager
    @Environment(\.modelContext) private var modelContext

    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusName: Bool

    var body: some View {
        ZStack(alignment: .topTrailing) {
            // CONTENT (unchanged) ...
            VStack(spacing: 18) {
                Text("Name your mix")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(.top, 30)

                VStack(spacing: 6) {
                    TextField("My mix…", text: $name)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                        .focused($focusName)
                        .foregroundStyle(.white)
                    Rectangle().fill(Color.white.opacity(0.6)).frame(height: 1)
                }
                .padding(.horizontal, 20)

                Button {
                    let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty else { return }

                    onSave(trimmed)
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.9))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(
                            LinearGradient(colors: [.white, .white.opacity(0.86)],
                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(radius: 3, y: 1)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                .opacity(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.6 : 1)

                Spacer(minLength: 0)
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(red: 90/255,  green: 134/255, blue: 179/255), location: 0.00),
                        .init(color: Color(red: 71/255,  green: 115/255, blue: 164/255), location: 0.35),
                        .init(color: Color(red: 45/255,  green:  94/255, blue: 142/255), location: 0.70),
                        .init(color: Color(red: 18/255,  green:  58/255, blue:  98/255), location: 1.00)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )

            Button { dismiss() } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.9))
                    .padding(.top, 10)
                    .padding(.trailing, 14)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                focusName = true
            }
        }
    }
}


#Preview {
    AddMixSheetView(name: .constant(""), data : []) { _ in }
}
