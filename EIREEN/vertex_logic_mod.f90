module vertex_logic_mod

        implicit none
        double precision, dimension(:,:),allocatable :: knots_EIRENE
        integer, dimension(:,:), allocatable :: triangles_EIRENE, triangle_back_interp_EIRENE
        integer, dimension(2) :: shape_knots,shape_triangles,shape_triangle_back_interp

    
    contains
    subroutine readin_data()

        implicit none
        !
        integer :: i
        integer :: file_id_knots,file_id_triangles,file_id_triangle_back_interp
        character(50) :: filename_knots,filename_triangles,filename_triangle_back_interp
!
!
        !---------------------------------------------------------------------------------------------------------------------!
        !Load EIRENE mesh data
!
        !Define file ids and filenames for EIRENE mesh data
        file_id_knots = 501
        filename_knots = 'EIREEN/knots.dat'
!
        file_id_triangles = 502
        filename_triangles = 'EIREEN/triangles.dat'
!
        file_id_triangle_back_interp = 503
        filename_triangle_back_interp = 'EIREEN/triangle_back_interp.dat'
!
        !Load knots
        open(unit=file_id_knots, file=filename_knots, status='unknown')
        read(file_id_knots,*) shape_knots
        allocate(knots_EIRENE(shape_knots(1),shape_knots(2)))
        do i = 1,shape_knots(1)
        read(file_id_knots,*) knots_EIRENE(i,:)
        enddo
        close(file_id_knots)
!       print *, 'knots_EIRENE(shape_knots(1),:)',knots_EIRENE(shape_knots(1),:)
!
        !Load triangles
        open(unit=file_id_triangles, file=filename_triangles, status='unknown')
        read(file_id_triangles,*) shape_triangles
        allocate(triangles_EIRENE(shape_triangles(1),shape_triangles(2)))
        do i = 1,shape_triangles(1)
        read(file_id_triangles,*) triangles_EIRENE(i,:)
        enddo
        close(file_id_triangles)
!        print *, 'triangles_EIRENE(1,:)',triangles_EIRENE(1,:)
!
        !Load triangle_back_interp
        open(unit=file_id_triangle_back_interp, file=filename_triangle_back_interp, status='unknown')
        read(file_id_triangle_back_interp,*) shape_triangle_back_interp
        allocate(triangle_back_interp_EIRENE(shape_triangle_back_interp(1),shape_triangle_back_interp(2)))
        do i = 1,shape_triangle_back_interp(1)
        read(file_id_triangle_back_interp,*) triangle_back_interp_EIRENE(i,:)
        enddo
        close(file_id_triangle_back_interp)
!        print *, 'triangle_back_interp_EIRENE(shape_triangle_back_interp(1))', & 
!        triangle_back_interp_EIRENE(shape_triangle_back_interp(1),1)
!
        
    end subroutine readin_data

function check_orientation(i_triangle)
        implicit none
        integer, intent(in) :: i_triangle
        double precision :: a,b,c,d, angle
        logical :: check_orientation

        a = knots_EIRENE(triangles_EIRENE(i_triangle,2),1) - knots_EIRENE(triangles_EIRENE(i_triangle,1),1)
        b = knots_EIRENE(triangles_EIRENE(i_triangle,2),2) - knots_EIRENE(triangles_EIRENE(i_triangle,1),2)
        c = knots_EIRENE(triangles_EIRENE(i_triangle,3),1) - knots_EIRENE(triangles_EIRENE(i_triangle,1),1)
        d = knots_EIRENE(triangles_EIRENE(i_triangle,3),2) - knots_EIRENE(triangles_EIRENE(i_triangle,1),2)

        ! perpendicular dot product -> sign of shortest angle between two vectors
        angle = a*d - b*c
        check_orientation = angle > 0 ! -> then counterclockwise (mathematical positiv)

end function check_orientation

function check_quadra_decomp()
        integer, dimension(:), allocatable :: check_quadra_decomp
        integer, dimension(3) :: current_triangle, partner_triangle
        integer :: m,n

        if (.not. allocated(check_quadra_decomp)) then
                allocate(check_quadra_decomp(shape_triangle_back_interp(1)))
        end if

        check_quadra_decomp = 0

        do m = 1, shape_triangle_back_interp(1)
                current_triangle = triangle_back_interp_EIRENE(m,:)
                do n = m + 1, shape_triangle_back_interp(1)
                        partner_triangle = triangle_back_interp_EIRENE(n,:)
                        if (all(current_triangle == partner_triangle)) then
                                check_quadra_decomp(m) = check_quadra_decomp(m) + 1
                                check_quadra_decomp(n) = check_quadra_decomp(n) + 1
                        end if
                end do
        end do

end function check_quadra_decomp

end module vertex_logic_mod