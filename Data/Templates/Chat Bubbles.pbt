Assets {
  Id: 10457911550827076401
  Name: "Chat Bubbles"
  PlatformAssetType: 5
  TemplateAsset {
    ObjectBlock {
      RootId: 4097850114913135674
      Objects {
        Id: 4097850114913135674
        Name: "Chat Bubbles"
        Transform {
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4781671109827199097
        ChildIds: 16922801037329393001
        UnregisteredParameters {
          Overrides {
            Name: "cs:MaxWidth"
            Int: 400
          }
          Overrides {
            Name: "cs:MaxHeight"
            Int: 150
          }
          Overrides {
            Name: "cs:FontSize"
            Int: 14
          }
          Overrides {
            Name: "cs:Offset"
            Int: 30
          }
          Overrides {
            Name: "cs:SpaceBetweenBubbles"
            Int: 12
          }
          Overrides {
            Name: "cs:DisplayTime"
            Float: 7
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Folder {
          IsGroup: true
        }
      }
      Objects {
        Id: 16922801037329393001
        Name: "ClientContext"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 4097850114913135674
        ChildIds: 5663970880891000241
        ChildIds: 8424639974216350150
        Collidable_v2 {
          Value: "mc:ecollisionsetting:forceoff"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        NetworkContext {
        }
      }
      Objects {
        Id: 5663970880891000241
        Name: "ChatBubblesClient"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 16922801037329393001
        UnregisteredParameters {
          Overrides {
            Name: "cs:RootGroup"
            ObjectReference {
              SubObjectId: 4097850114913135674
            }
          }
          Overrides {
            Name: "cs:UserInterface"
            ObjectReference {
              SubObjectId: 8424639974216350150
            }
          }
          Overrides {
            Name: "cs:ChatBubbleTemplate"
            AssetReference {
              Id: 6832858366577709735
            }
          }
          Overrides {
            Name: "cs:PlayerInterfaceTemplate"
            AssetReference {
              Id: 13120981541341342186
            }
          }
          Overrides {
            Name: "cs:PlayerHeadTemplate"
            AssetReference {
              Id: 8658941642497290693
            }
          }
        }
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Script {
          ScriptAsset {
            Id: 16049094687575064429
          }
        }
      }
      Objects {
        Id: 8424639974216350150
        Name: "User Interface"
        Transform {
          Location {
          }
          Rotation {
          }
          Scale {
            X: 1
            Y: 1
            Z: 1
          }
        }
        ParentId: 16922801037329393001
        Collidable_v2 {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        Visible_v2 {
          Value: "mc:evisibilitysetting:inheritfromparent"
        }
        CameraCollidable {
          Value: "mc:ecollisionsetting:inheritfromparent"
        }
        EditorIndicatorVisibility {
          Value: "mc:eindicatorvisibility:visiblewhenselected"
        }
        Control {
          RenderTransformPivot {
            Anchor {
              Value: "mc:euianchor:middlecenter"
            }
          }
          Canvas {
            ContentType {
              Value: "mc:ecanvascontenttype:dynamic"
            }
            Opacity: 1
          }
          AnchorLayout {
            SelfAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
            TargetAnchor {
              Anchor {
                Value: "mc:euianchor:topleft"
              }
            }
          }
        }
      }
    }
    PrimaryAssetId {
      AssetType: "None"
      AssetId: "None"
    }
  }
  SerializationVersion: 87
}
